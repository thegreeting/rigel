import 'package:altair/domain/entity/campaign/campaign.entity.dart';
import 'package:altair/domain/entity/exception/network_exception.entity.dart';
import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/interface_adapter/repository/ethereum_connector.dart';
import 'package:quiver/iterables.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../domain/entity/account/wallet_account.entity.dart';
import '../../logger.dart';
import 'greeting.contract.dart';

class GreetingRepository {
  GreetingRepository(
    this.connector,
    this.contract,
  );

  final EthereumConnector connector;
  final DeployedContract contract;

  Future<List<ShallowCampaign>> getShallowCampaigns() async {
    final result = await connector.callContract(
      contract,
      'getCampaignListAndName',
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
    return campaigns;
  }

  Future<Message> getMessageById(String campaignId, int id) async {
    logger.info('🙋 getMessageById: $id of campaign: $campaignId');
    final messageRaws = await (() async {
      try {
        return connector.callContract(
          contract,
          'getMessageByIdOfCampaign',
          params: <dynamic>[
            EthereumAddress.fromHex(campaignId),
            BigInt.from(id),
          ],
        );
      } on RPCError catch (e) {
        logger.warning(e.toString());
        if (e.errorCode == 3) {
          throw NotFound();
        }
        throw NetworkException();
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        throw NetworkException(failureReason: e.toString());
      }
    })();
    if (messageRaws.isEmpty) {
      throw NotFound();
    }

    final messageRaw = messageRaws[0] as List<dynamic>;
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
