import 'package:altair/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

import '../domain/entity/account/wallet_account.entity.dart';
import '../domain/state/connection.state.dart';
import '../interface_adapter/repository/ethereum_connector.dart';
import '../interface_adapter/repository/greeting.contract.dart';
import '../interface_adapter/repository/greeting.repository.dart';

final ethereumConnectorProvider = Provider<EthereumConnector>((ref) {
  return EthereumConnector();
});

final theGreetingFacadeContractAddressProvider = Provider<EthereumAddress>((ref) {
  // this is overritten while app startup. see also main.dart
  return EthereumAddress.fromHex('0x7cD6D292680ba5a776ECA7F062B0eE0c717e6F0A');
});

final theGreetingFacadeDeployedContractProvider = Provider<DeployedContract>(
  (ref) {
    final contractAddress = ref.watch(theGreetingFacadeContractAddressProvider);
    return DeployedContract(
      ContractAbi.fromJson(theGreetingContractAbi, 'The Greeting'),
      contractAddress,
    );
  },
);

final greetingRepositoryProvider = Provider<GreetingRepository>((ref) {
  return GreetingRepository(
    ref.watch(ethereumConnectorProvider),
    ref.watch(theGreetingFacadeDeployedContractProvider),
  );
});

final connectionStateProvider =
    StateNotifierProvider<ConnectionStateNotifier, WalletConnectionState>((ref) {
  return ConnectionStateNotifier(
    ref,
    ref.watch(ethereumConnectorProvider),
  );
});

final myWalletAddressProvider = Provider<EthereumAddress?>((ref) {
  final connectionState = ref.watch(connectionStateProvider);
  if (connectionState == WalletConnectionState.connected) {
    final hex = ref.read(connectionStateProvider.notifier).connector.address;
    return EthereumAddress.fromHex(hex);
  } else {
    return null;
  }
});
final isWalletConnectedProvider = Provider<bool>((ref) {
  return ref.watch(myWalletAddressProvider) != null;
});
final myWalletAccountProvider = Provider<WalletAccount?>((ref) {
  final address = ref.watch(myWalletAddressProvider);
  if (address == null) {
    return null;
  }
  return WalletAccount.fromWalletAddress(address);
});

class ConnectionStateNotifier extends StateNotifier<WalletConnectionState> {
  ConnectionStateNotifier(
    this.ref,
    this.connector,
  ) : super(WalletConnectionState.disconnected);

  final Ref ref;
  EthereumConnector connector;

  Future<void> connect({
    required Future<SessionStatus?> Function(EthereumConnector connector) onCallConnect,
    VoidCallback? onConnected,
  }) async {
    state = WalletConnectionState.connecting;
    try {
      final session = await onCallConnect(connector);
      if (session != null) {
        logger.info('Session connected: $session');
        state = WalletConnectionState.connected;
        logger.info('Wallet address: ${session.accounts.first}');
        await Future<void>.delayed(Duration.zero);
        onConnected?.call();
      } else {
        state = WalletConnectionState.connectionCancelled;
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.severe(e.toString());
      state = WalletConnectionState.connectionFailed;
    }
  }

  Future<void> disconnect() async {
    state = WalletConnectionState.disconnected;
    connector = EthereumConnector();
  }
}

Future<EthereumAddress> loadTheGreetingFacadeContractAddress() async {
  return getTheGreetingContractAddressViaProxy(EthereumConnector());
}
