import 'dart:convert';

import 'package:ens_dart/ens_dart.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/iterables.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../application/config/constant.dart';
import '../../domain/entity/account/wallet_account.entity.dart';
import '../../domain/entity/campaign/campaign.entity.dart';
import '../../domain/entity/campaign/greeting_word.entity.dart';
import '../../domain/entity/exception/network_exception.entity.dart';
import '../../domain/entity/exception/util/recoverable_exception.entity.dart';
import '../../domain/entity/messsage/message.entity.dart';
import '../../domain/entity/messsage/message_type.enum.dart';
import '../../domain/entity/primitive/image_object.entity.dart';
import '../../domain/entity/primitive/person.entity.dart';
import '../../logger.dart';
import 'ethereum_connector.dart';

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

  Future<EtherAmount> getPricePerMessageInWei(String campaignId) async {
    logger.info('getPricePerMessageInEther');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'getPricePerMessageInWei',
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
        ],
      ),
    );

    final price = result[0] as BigInt;
    return EtherAmount.inWei(price);
  }

  Future<String> sendMessage(
    String campaignId, {
    required String receiverId,
    String messageUrl = '',
    EtherAmount? amount,
  }) async {
    logger.info('sendMessage: $campaignId, $receiverId, $messageUrl');
    final txHash = await _interactWithSendTransactionGuard(
      () => connector.sendTransactionViaContract(
        contract,
        'send',
        value: amount,
        params: <dynamic>[
          EthereumAddress.fromHex(campaignId),
          EthereumAddress.fromHex(receiverId),
          messageUrl,
        ],
      ),
    );
    return txHash;
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
    final sender = messageRaw[1].toString(); // address
    final recipient = messageRaw[2].toString(); // address
    final greetingWord = messageRaw[3].toString();
    final messageUrl = messageRaw[4].toString() == '' ? null : messageRaw[4].toString();
    final status = MessageStatus.fromValue((messageRaw[5] as BigInt).toInt());
    final isResonanced = messageRaw[6] as bool;

    String? description;
    String? imageUrl;
    if (messageUrl != null) {
      logger.info('messageUrl: $messageUrl');
      final ipfsContentId = messageUrl.split('/')[2];
      final ipfsContentUrl = '${AppConstant.ipfsGatewayUrl}$ipfsContentId';
      logger.info('ipfsContentUrl: $ipfsContentUrl');
      // get json content by http request.
      // TODO(knaoe): consider Retry.
      final response = await http.get(Uri.parse(ipfsContentUrl));
      final responseBody = utf8.decode(response.bodyBytes);
      final json = jsonDecode(responseBody) as Map<String, dynamic>;
      logger.info('content: $json');
      description = json['description'] as String?;
      imageUrl = json['image'] as String?;
    }
    return Message(
      id: id.toString(),
      description: description ?? '',
      dateCreated: DateTime.now(),
      author: Person(
        id: sender,
        name: sender,
      ),
      image: imageUrl != null
          ? ImageObject(
              id: imageUrl,
              contentUrl: imageUrl,
              width: 512,
              height: 512, // TODO(knaoe): get image size.
            )
          : ImageObject.dummy(id: id.toString()),
      sender: WalletAccount(
        id: sender,
        name: sender,
      ),
      recipient: WalletAccount(
        id: recipient,
        name: recipient,
      ),
      greetingWord: greetingWord,
      status: status,
      isResonanced: isResonanced,
    );
  }

  Future<void> verifyHumanity() async {
    logger.info('verifyHumanity');
    await _interactWithSendTransactionGuard(
      () => connector.sendTransactionViaContract(
        contract,
        'verifyHumanity',
        params: <dynamic>[],
      ),
    );
  }

  Future<bool> isHumanityVerified(String callerId) async {
    logger.info('isHumanityVerified');
    final result = await _interactWithCallContractGuard(
      () => connector.callContract(
        contract,
        'isHumanityVerified',
        params: <dynamic>[
          EthereumAddress.fromHex(callerId),
        ],
      ),
    );
    return result[0] as bool;
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

  Future<String> _interactWithSendTransactionGuard(
    Future<String> Function() callback,
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
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      rethrow;
    }
  }
}

Future<EthereumAddress> getTheGreetingContractAddressByENS(
  Ens ens,
) async {
  final address =
      await ens.withName(AppConstant.theGreetingFacadeContractName).getAddress();

  return address;
}
