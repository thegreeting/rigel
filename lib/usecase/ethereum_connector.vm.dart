import 'package:altair/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import '../domain/state/connection.state.dart';
import '../interface_adapter/repository/ethereum_connector.dart';
import '../interface_adapter/repository/greeting.repository.dart';

final ethereumConnectorProvider = Provider<EthereumConnector>((ref) {
  return EthereumConnector();
});

final greetingRepositoryProvider = Provider<GreetingRepository>((ref) {
  return GreetingRepository(
    ref.watch(ethereumConnectorProvider),
  );
});

final connectionStateProvider =
    StateNotifierProvider<ConnectionStateNotifier, WalletConnectionState>((ref) {
  return ConnectionStateNotifier(
    ref,
    ref.watch(ethereumConnectorProvider),
  );
});

final myWalletAddressProvider = StateProvider<String?>((_) => null);
final isWalletConnectedProvider = Provider<bool>((ref) {
  return ref.watch(myWalletAddressProvider) != null;
});

class ConnectionStateNotifier extends StateNotifier<WalletConnectionState> {
  ConnectionStateNotifier(
    this.ref,
    this.connector,
  ) : super(WalletConnectionState.disconnected);

  final Ref ref;
  final EthereumConnector connector;

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
        ref.read(myWalletAddressProvider.notifier).update((state) => connector.address);
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
  }
}
