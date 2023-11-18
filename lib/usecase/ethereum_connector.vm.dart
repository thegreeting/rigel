import 'package:ens_dart/ens_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import '../application/config/constant.dart';
import '../domain/entity/account/wallet_account.entity.dart';
import '../domain/state/connection.state.dart';
import '../interface_adapter/repository/ethereum_connector.dart';
import '../interface_adapter/repository/greeting.contract.dart';
import '../interface_adapter/repository/greeting.repository.dart';
import '../logger.dart';
import '../util/flavor.provider.dart';

final isTestnetProvider =
    Provider<bool>((ref) => ref.watch(flavorProvider) != Flavor.mainnet);

final ethChainIdProvider = Provider<String>((ref) {
  final flavor = ref.watch(flavorProvider);
  return AppConstant.getChainId(flavor);
});

final ethRpcUrlProvider = Provider<String>((ref) {
  final flavor = ref.watch(flavorProvider);
  return AppConstant.getEthRpcUrl(flavor);
});

final ethereumConnectorProvider = Provider<EthereumConnector>((ref) {
  final chainId = ref.watch(ethChainIdProvider);
  return EthereumConnector(
    chainId: chainId,
  );
});

final ensProvider = Provider<Ens>(
  (ref) {
    final connector = ref.watch(ethereumConnectorProvider);
    final ethRpcUrl = ref.watch(ethRpcUrlProvider);
    return initEns(connector, ethRpcUrl);
  },
);

final theGreetingFacadeContractAddressProvider =
    FutureProvider<EthereumAddress>((ref) async {
  final ens = ref.watch(ensProvider);
  final address = await getTheGreetingContractAddressByENS(ens);
  logger.info(
    '🟢 The Greeting Facade Contract Address: $address',
  );
  return address;
});

final theGreetingFacadeDeployedContractProvider = FutureProvider<DeployedContract>(
  (ref) async {
    final contractAddress =
        await ref.watch(theGreetingFacadeContractAddressProvider.future);
    return DeployedContract(
      ContractAbi.fromJson(theGreetingContractAbi, 'The Greeting'),
      contractAddress,
    );
  },
);

final greetingRepositoryProvider = FutureProvider<GreetingRepository>((ref) async {
  return GreetingRepository(
    ref.watch(ethereumConnectorProvider),
    await ref.watch(theGreetingFacadeDeployedContractProvider.future),
  );
});

final connectionStateProvider =
    StateNotifierProvider<ConnectionStateNotifier, WalletConnectionState>((ref) {
  return ConnectionStateNotifier(
    ref,
    ref.watch(ethereumConnectorProvider),
  )..init();
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
  final maybeName = await getENSNameWithAddress(ref, EthereumAddress.fromHex(address));
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
  final amount = await connector.getBalance();
  return amount;
});

class ConnectionStateNotifier extends StateNotifier<WalletConnectionState> {
  ConnectionStateNotifier(
    this.ref,
    this.connector,
  ) : super(WalletConnectionState.disconnected);

  final Ref ref;
  EthereumConnector connector;

  Future<void> init() async {
    connector.service.addListener(serviceListener);
    connector.service.web3App?.onSessionEvent.subscribe((event) {
      logger.info('onSessionEvent: $event');
    });
  }

  Future<void> connect({
    required Future<dynamic> Function(EthereumConnector connector) onCallConnect,
    VoidCallback? onConnected,
  }) async {
    state = WalletConnectionState.connecting;
    try {
      await onCallConnect(connector);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.severe(e.toString());
      state = WalletConnectionState.connectionFailed;
    }
  }

  void serviceListener() {
    logger.info('session connected: ${connector.service.isConnected}');
    if (connector.service.isConnected) {
      logger.fine('service metadata: ${connector.service.web3App?.metadata}');
      final sessions = connector.service.web3App?.getActiveSessions();
      if (sessions != null && sessions.isNotEmpty) {
        state = WalletConnectionState.connected;
      } else {
        state = WalletConnectionState.disconnected;
      }
    } else {
      state = WalletConnectionState.disconnected;
    }
  }

  Future<void> disconnect() async {
    state = WalletConnectionState.disconnected;
    connector = ref.refresh(ethereumConnectorProvider);
    connector.service.removeListener(serviceListener);
  }
}

Future<EthereumAddress> getAddressWithENSName(WidgetRef ref, String name) async {
  final ens = ref.watch(ensProvider);
  return ens.withName(name).getAddress();
}

Future<String> getENSNameWithAddress(Ref ref, EthereumAddress address) async {
  final ens = ref.watch(ensProvider);
  try {
    final name = await ens.withAddress(address).getName();
    if (name != '') {
      return name;
    } else {
      logger.warning('No ENS name found for address: ${address.hex}');
      return address.hex;
    }
    // ignore: avoid_catching_errors
  } on RangeError catch (_) {
    return address.hex;
  }
}

String buildDisplayAddressText(String address) {
  return address.substring(0, 8);
}
