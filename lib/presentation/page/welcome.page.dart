import 'package:altair/presentation/atom/caption_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../domain/state/connection.state.dart';
import '../../usecase/ethereum_connector.vm.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(connectionStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Greeting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(connectionStateProvider.notifier).connect(
                      onCallConnect: (connector) => connector.connect(context),
                      onConnected: () => context.push('/home'),
                    );
              },
              child: const Text('Connect Wallet'),
            ),
            const Gap(16),
            if (connectionState != WalletConnectionState.disconnected)
              CaptionText(transactionStateToString(connectionState)),
          ],
        ),
      ),
    );
  }

  String transactionStateToString(WalletConnectionState state) {
    switch (state) {
      case WalletConnectionState.disconnected:
        return 'Not connected yet.';
      case WalletConnectionState.connecting:
        return 'Connecting';
      case WalletConnectionState.connected:
        return 'Session connected';
      case WalletConnectionState.connectionFailed:
        return 'Connection failed';
      case WalletConnectionState.connectionCancelled:
        return 'Connection cancelled';
    }
  }
}
