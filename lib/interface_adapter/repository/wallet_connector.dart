import 'package:flutter/widgets.dart';
import 'package:web3dart/web3dart.dart';

abstract class WalletConnector {
  Future<void> connect(BuildContext context);

  Future<String?> sendAmount({
    required String recipientAddress,
    required double amount,
  });

  Future<void> openWalletApp();

  Future<EtherAmount> getBalance();

  bool validateAddress({required String address});

  String get faucetUrl;

  String? get address;

  String get coinName;
}
