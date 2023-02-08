import 'dart:typed_data';

import 'package:altair/application/config/constant.dart';
import 'package:altair/logger.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'wallet_connector.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(
    Uint8List payload, {
    int? chainId,
    bool isEIP1559 = false,
  }) {
    throw UnimplementedError();
  }

  @override
  // TODO(knaoe): implement address
  EthereumAddress get address => throw UnimplementedError();

  @override
  MsgSignature signToEcSignature(
    Uint8List payload, {
    int? chainId,
    bool isEIP1559 = false,
  }) {
    // TODO(knaoe): implement signToEcSignature
    throw UnimplementedError();
  }
}

class EthereumConnector implements WalletConnector {
  // TODO(knaoe): chainId should be configurable
  EthereumConnector() {
    _connector = WalletConnectQrCodeModal(
      connector: WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          name: 'The Greeting',
          description: 'Your web3 postcards - simple but authentic.',
          url: 'https://walletconnect.org',
          icons: [
            // TODO(knaoe): use the real icon
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      ),
    );

    _provider = EthereumWalletConnectProvider(_connector.connector);
  }
  late final WalletConnectQrCodeModal _connector;
  late final EthereumWalletConnectProvider _provider;

  @override
  Future<SessionStatus?> connect(BuildContext context) async {
    return _connector.connect(context, chainId: AppConstant.getChainId());
  }

  @override
  void registerListeners(
    OnConnectRequest? onConnect,
    OnSessionUpdate? onSessionUpdate,
    OnDisconnect? onDisconnect,
  ) =>
      _connector.registerListeners(
        onConnect: onConnect,
        onSessionUpdate: onSessionUpdate,
        onDisconnect: onDisconnect,
      );

  @override
  Future<String?> sendAmount({
    required String recipientAddress,
    required double amount,
  }) async {
    final sender = EthereumAddress.fromHex(_connector.connector.session.accounts[0]);
    final recipient = EthereumAddress.fromHex(address);

    final etherAmount =
        EtherAmount.fromInt(EtherUnit.szabo, (amount * 1000 * 1000).toInt());

    final transaction = Transaction(
      to: recipient,
      from: sender,
      gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 100000,
      value: etherAmount,
    );

    final credentials = WalletConnectEthereumCredentials(provider: _provider);

    try {
      final txBytes = await _ethereum.sendTransaction(credentials, transaction);
      return txBytes;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.severe('Error: $e');
    }

    await _connector.killSession();

    return null;
  }

  Future<List<dynamic>> callContract(
    DeployedContract contract,
    String functionName, {
    List<dynamic> params = const <dynamic>[],
  }) async {
    try {
      final result = await _ethereum.call(
        contract: contract,
        function: contract.function(functionName),
        params: params,
      );
      logger.info('callContract $functionName result: $result');
      return result;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.severe('Error: $e');
      // TODO(knaoe): convert to ContractException
      rethrow;
    }
  }

  Future<String> sendTransactionViaContract(
    DeployedContract contract,
    String functionName, {
    EtherAmount? value,
    List<dynamic> params = const <dynamic>[],
  }) async {
    final sender = EthereumAddress.fromHex(_connector.connector.session.accounts[0]);
    final credentials = WalletConnectEthereumCredentials(provider: _provider);
    var txHash = '';
    try {
      txHash = await _ethereum.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: contract.function(functionName),
          from: sender,
          value: value,
          nonce: await _ethereum.getTransactionCount(
            sender,
            atBlock: const BlockNum.pending(),
          ),
          parameters: params,
        ),
        chainId: AppConstant.getChainId(),
      );
      logger.info(txHash);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.severe('Error: $e');
      rethrow;
    }
    return txHash;
  }

  @override
  Future<void> openWalletApp() async => _connector.openWalletApp();

  @override
  Future<double> getBalance() async {
    final address = EthereumAddress.fromHex(_connector.connector.session.accounts[0]);
    final amount = await _ethereum.getBalance(address);
    return amount.getValueInUnit(EtherUnit.ether);
  }

  @override
  bool validateAddress({required String address}) {
    try {
      EthereumAddress.fromHex(address);
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return false;
    }
  }

  @override
  String get faucetUrl => 'https://faucet.dimensions.network/';

  @override
  String get address => _connector.connector.session.accounts[0];

  @override
  String get coinName => 'Eth';

  final _ethereum = Web3Client(
    AppConstant.getEthRpcUrl(),
    Client(),
    // socketConnector: () {
    //   return IOWebSocketChannel.connect(
    //     AppConstant.ethGoerliWsUrl,
    //   ).cast<String>();
    // },
    // ,}
  );

  Web3Client get client => _ethereum;
}

Ens initEns(EthereumConnector connector, {int? chainId}) {
  final client = connector.client;
  final resolvedChainId = chainId ?? AppConstant.getChainId();
  final isMainnet = resolvedChainId == 1;

  final ensResolverAddress =
      isMainnet ? null : EthereumAddress.fromHex(AppConstant.goerliEnsResolverAddress);
  final ens = Ens(client: client, address: ensResolverAddress);
  return ens;
}
