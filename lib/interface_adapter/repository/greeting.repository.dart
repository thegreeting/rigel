import 'package:altair/domain/entity/exception/network_exception.entity.dart';
import 'package:altair/domain/entity/messsage/message.entity.dart';
import 'package:altair/interface_adapter/repository/ethereum_connector.dart';
import 'package:altair/interface_adapter/repository/greeting_campaign.contract.dart';

import '../../domain/entity/account/wallet_account.entity.dart';

class GreetingRepository {
  GreetingRepository(
    this.connector,
  );

  final EthereumConnector connector;
  final contract = greetingCampaignContract;

  Future<Message> getMessageById(String id) async {
    final messageRaws = await connector.callContract(
      contract,
      'getMessageById',
      params: <dynamic>[
        BigInt.from(int.parse(id)),
      ],
    );
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
