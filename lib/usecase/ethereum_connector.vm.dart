import 'package:altair/application/config/constant.dart';
import 'package:altair/logger.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

import '../domain/entity/account/wallet_account.entity.dart';
import '../domain/state/connection.state.dart';
import '../interface_adapter/repository/ethereum_connector.dart';
import '../interface_adapter/repository/greeting.contract.dart';
import '../interface_adapter/repository/greeting.repository.dart';
import '../util/flavor.provider.dart';

final ethereumConnectorProvider = Provider<EthereumConnector>((ref) {
  return EthereumConnector();
});

final ensProvider = Provider<Ens>(
  (ref) {
    final flavor = ref.watch(flavorProvider);
    final chainId = AppConstant.getChainId(flavor);
    final connector = ref.watch(ethereumConnectorProvider);
    return initEns(connector, chainId: chainId);
  },
);

final theGreetingFacadeContractAddressProvider = Provider<EthereumAddress>((ref) {
  /// this is overritten while app startup. see also [lib/main.dart]
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

final walletDisplayAddressOrNameProviders =
    FutureProvider.family<String, String>((ref, address) async {
  final maybeName = await getENSNameWithAddress(EthereumAddress.fromHex(address));
  if (maybeName.startsWith('0x')) {
    return buildDisplayAddressText(address);
  } else {
    return maybeName;
  }
});

final myWalletAddressOrNameProvider = FutureProvider<String?>((ref) {
  final address = ref.watch(myWalletAddressProvider);
  if (address == null) {
    return null;
  }
  return ref.watch(walletDisplayAddressOrNameProviders(address.hex).future);
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

final myWalletAmountProvider = FutureProvider<EtherAmount>((ref) async {
  final address = ref.watch(myWalletAddressProvider);
  if (address == null) {
    return EtherAmount.zero();
  }
  final connector = ref.watch(ethereumConnectorProvider);
  final amount = await connector.client.getBalance(address);
  return amount;
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
  final ens = initEns(EthereumConnector());
  return getTheGreetingContractAddressByENS(ens);
}

Future<EthereumAddress> getAddressWithENSName(String name) async {
  final ens = initEns(EthereumConnector());
  return ens.withName(name).getAddress();
}

Future<String> getENSNameWithAddress(EthereumAddress address) async {
  final ens = initEns(EthereumConnector());
  try {
    return await ens.withAddress(address).getName();
    // ignore: avoid_catching_errors
  } on RangeError catch (_) {
    return address.hex;
  }
}

String buildDisplayAddressText(String address) {
  return address.substring(0, 8);
}
