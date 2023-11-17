import 'package:ens_dart/ens_dart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../../application/config/constant.dart';
import '../../logger.dart';
import 'utils/web3dart_extension.dart';
import 'wallet_connector.dart';

class EthereumConnector implements WalletConnector {
  // TODO(knaoe): chainId should be configurable
  EthereumConnector({
    required this.chainIdInNamespace,
  }) {
    service = W3MService(
      projectId: AppConstant.walletConnectV2ProjectId,
      metadata: const PairingMetadata(
        name: 'The Greeting',
        description: 'Your web3 postcards - simple but authentic.',
        url: 'https://greeting.network',
        icons: [
          // TODO(knaoe): replace logo.
          'https://greeting.network/favicon.png',
        ],
        redirect: Redirect(
          native: 'greeting://',
          universal: 'https://greeting.network',
        ),
      ),
      requiredNamespaces: {
        'eip155': const W3MNamespace(
          methods: [
            'personal_sign',
            'eth_signTypedData',
            'eth_sendTransaction',
          ],
          events: [
            'chainChanges',
            'accountsChanges',
          ],
          chains: [
            'eip155:1',
          ],
        ),
      },
      optionalNamespaces: {
        'eip155': const W3MNamespace(
          methods: [
            'personal_sign',
            'eth_signTypedData',
            'eth_sendTransaction',
          ],
          events: [
            'chainChanges',
            'accountsChanges',
          ],
          chains: [
            'eip155:5',
          ],
        ),
      },
      logLevel: LogLevel.debug,
    );
    service.init();
  }

  final String chainIdInNamespace;
  late final W3MService service;
  SessionConnect? currentSession;

  @override
  Future<void> connect(BuildContext context) async {
    await service.openModal(context);
    service.web3App?.onSessionConnect.subscribe((args) {
      logger.info('onSessionConnect: $args');
      currentSession = args;
    });
  }

  @override
  Future<String?> sendAmount({
    required String recipientAddress,
    required double amount,
  }) async {
    if (currentSession == null) {
      throw Exception('currentSession is null');
    }
    final sender = EthereumAddress.fromHex(address);
    final recipient = EthereumAddress.fromHex(recipientAddress);

    final etherAmount =
        EtherAmount.fromInt(EtherUnit.szabo, (amount * 1000 * 1000).toInt());

    final transaction = Transaction(
      to: recipient,
      from: sender,
      gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 100000,
      value: etherAmount,
    );

    try {
      final txBytes = await service.web3App?.request(
        topic: currentSession!.session.topic,
        chainId: chainIdInNamespace,
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [transaction.toJson()],
        ),
      );
      return txBytes as String?;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.severe('Error: $e');
    }

    return null;
  }

  Future<List<dynamic>> callContract(
    DeployedContract contract,
    String functionName, {
    List<dynamic> params = const <dynamic>[],
  }) async {
    if (currentSession == null) {
      throw Exception('currentSession is null');
    }
    final transaction = Transaction.callContract(
      contract: contract,
      function: contract.function(functionName),
      parameters: params,
    );
    try {
      final result = await service.web3App?.request(
        topic: currentSession!.session.topic,
        chainId: chainIdInNamespace,
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [transaction.toJson(fromAddress: address)],
        ),
      );
      logger.info('callContract $functionName result: $result');
      return result as List<dynamic>;
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
    final sender = EthereumAddress.fromHex(address);

    final transaction = Transaction.callContract(
      contract: contract,
      function: contract.function(functionName),
      from: sender,
      value: value,
      parameters: params,
      // nonce: await _ethereum.getTransactionCount(
      //   sender,
      //   atBlock: const BlockNum.pending(),
      // ),
    );
    try {
      final txHash = await service.web3App?.request(
        topic: 'topic',
        chainId: 'eip155:$chainIdInNamespace',
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [transaction.toJson()],
        ),
      );
      logger.info(txHash);
      // ignore: avoid_catches_without_on_clauses
      return txHash as String;
    } on Exception catch (e) {
      logger.severe('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> openWalletApp() async => service.launchConnectedWallet();

  @override
  Future<EtherAmount> getBalance() async {
    throw UnimplementedError();
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
  String get address {
    final senderAddress = service.address;
    if (senderAddress == null) {
      throw Exception('senderAddress is null');
    }
    return senderAddress;
  }

  @override
  String get coinName => 'Eth';

  IWeb3App? get client => service.web3App;
}

Ens initEns(EthereumConnector connector, String ethRpcUrl) {
  final isMainnet = connector.chainIdInNamespace == '1';

  final ensResolverAddress =
      isMainnet ? null : EthereumAddress.fromHex(AppConstant.goerliEnsResolverAddress);
  final ethClient = Web3Client(
    ethRpcUrl,
    http.Client(),
  );
  final ens = Ens(client: ethClient, address: ensResolverAddress);
  return ens;
}
