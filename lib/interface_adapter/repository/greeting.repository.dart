import 'package:altair/domain/entity/campaign/campaign.entity.dart';
import 'package:altair/domain/entity/campaign/greeting_word.entity.dart';
import 'package:altair/domain/entity/exception/network_exception.entity.dart';
import 'package:altair/domain/entity/exception/util/recoverable_exception.entity.dart';
import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/interface_adapter/repository/ethereum_connector.dart';
import 'package:quiver/iterables.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../domain/entity/account/wallet_account.entity.dart';
import '../../logger.dart';
import 'greeting.contract.dart';

enum MessageType {
  incoming(0),
  sent(1);

  const MessageType(this.value);
  final int value;
}

class GreetingRepository {
  GreetingRepository(
    this.connector,
    this.contract,
  );

  final EthereumConnector connector;
  final DeployedContract contract;

  Future<List<ShallowCampaign>> getShallowCampaigns() async {
    logger.info('getShallowCampaigns');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'getCampaignListAndName',
      ),
    );

    final campaigns = <ShallowCampaign>[];
    for (final pair in zip<dynamic>(
      [
        result[0] as List<dynamic>,
        result[1] as List<dynamic>,
      ],
    )) {
      final id = pair[0] as EthereumAddress;
      final name = pair[1] as String;
      logger.info('id: $id, name: $name');
      campaigns.add(ShallowCampaign(id: id.hex, name: name));
    }
    logger.info('getShallowCampaigns: $campaigns');
    return campaigns;
  }

  Future<List<GreetingWord>> getGreetingWords(String campaignId) async {
    logger.info('getGreetingWords: $campaignId');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'getGreetingWordList',
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
        ],
      ),
    );

    final wordsIncludesNullAtFirstElm = List<String>.from(result[0] as List<dynamic>);
    assert(
      wordsIncludesNullAtFirstElm.isNotEmpty && wordsIncludesNullAtFirstElm.length >= 2,
    );
    // ignore first element because it is always empty.
    final wordsRaw = wordsIncludesNullAtFirstElm.sublist(1);
    return wordsRaw
        .asMap()
        .entries
        .map(
          (entry) => GreetingWord(
            // index starts from 1 because we are processing with sublisted list.
            id: '${entry.key + 1}',
            name: entry.value,
          ),
        )
        .toList();
  }

  Future<GreetingWord?> getSelectedGreetingWord(
    String campaignId,
    String senderId,
  ) async {
    logger.info('getSelectedGreetingWord: $campaignId');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'getSelectedGreetingWord',
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
          EthereumAddress.fromHex(senderId),
        ],
      ),
    );

    final index = result[0] as BigInt;
    final word = result[1] as String;
    if (index == BigInt.from(0)) {
      return null;
    }
    return GreetingWord(
      id: index.toString(),
      name: word,
    );
  }

  Future<void> setGreetingWordForWallet(
    String campaignId,
    int wordsIndex,
  ) async {
    logger.info('setGreetingWordForWallet: $campaignId, at $wordsIndex');
    await _interactWithSendTransactionGuard(
      () => connector.sendTransactionViaContract(
        contract,
        'selectGreetingWord',
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
          BigInt.from(wordsIndex),
        ],
      ),
    );
  }

  Future<List<BigInt>> getMessageIds(
    String campaignId,
    String accountId,
    MessageType type,
  ) async {
    logger.info('campaignId: $campaignId, accountId: $accountId, type: $type');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'getMessageIdsOfCampaign',
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
          EthereumAddress.fromHex(accountId),
          BigInt.from(type.value),
        ],
      ),
    );

    final idsRaw = result[0] as List<dynamic>;

    final messageIds = List<BigInt>.from(idsRaw);
    return messageIds;
  }

  Future<Message> getMessageById(String campaignId, BigInt id) async {
    logger.info('🙋 getMessageById: $id of campaign: $campaignId');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'getMessageByIdOfCampaign',
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
          id,
        ],
      ),
    );
    final messagesRaw = result;
    if (messagesRaw.isEmpty) {
      throw NotFound();
    }

    final messageRaw = messagesRaw[0] as List<dynamic>;
    return Message(
      id: messageRaw[0].toString(),
      description: 'Retrieve from IPFS',
      dateCreated: DateTime.now(),
      recipient: WalletAccount(
        id: messageRaw[1].toString(),
        name: messageRaw[1].toString(),
      ),
      sender: WalletAccount(
        id: messageRaw[2].toString(),
        name: messageRaw[2].toString(),
      ),
      greetingWord: messageRaw[3].toString(),
      status: MessageStatus.fromValue((messageRaw[5] as BigInt).toInt()),
      isResonanced: messageRaw[6] as bool,
    );
  }

  Future<List<dynamic>> _interactWithCallContractGuard(
    Future<List<dynamic>> Function() callback,
  ) async {
    try {
      return await callback();
    } on RPCError catch (e) {
      logger.warning(e.toString());
      if (e.errorCode == 3) {
        logger.finer(e.toString());
        throw NotFound();
      }
      throw NetworkException(failureReason: e.toString());
    } on RecoverableException catch (e) {
      logger.warning(e.toString());
      rethrow;
    }
  }

  Future<void> _interactWithSendTransactionGuard(
    Future<void> Function() callback,
  ) async {
    try {
      return await callback();
    } on RPCError catch (e) {
      logger.warning(e.toString());
      if (e.errorCode == 3) {
        logger.finer(e.toString());
        throw NotFound();
      }
      throw NetworkException(failureReason: e.toString());
    } on RecoverableException catch (e) {
      logger.warning(e.toString());
      rethrow;
    }
  }
}

Future<EthereumAddress> getTheGreetingContractAddressViaProxy(
  EthereumConnector connector,
) async {
  final results = await connector.callContract(
    theGreetingProxyContract,
    'getImplementationAddress',
  );
  final address = results[0] as EthereumAddress;
  return address;
}
