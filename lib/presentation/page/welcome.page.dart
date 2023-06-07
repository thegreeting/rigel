import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/config/constant.dart';
import '../../domain/state/connection.state.dart';
import '../../usecase/ethereum_connector.vm.dart';
import '../../util/flavor.provider.dart';
import '../atom/caption_text.dart';
import '../atom/title_text.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = ref.watch(flavorProvider);
    final connectionState = ref.watch(connectionStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/icon/theGreetingLauncher.png'),
                    width: 200,
                  ),
                  const Gap(32),
                  const TitleText(
                    'The Greeting',
                    style: TextStyle(fontSize: 32),
                  ),
                  const Gap(16),
                  const CaptionText(
                    'Your web3 postcards',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(4),
                  const CaptionText(
                    ' simple but authentic',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(32),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(connectionStateProvider.notifier).connect(
                            onCallConnect: (connector) => connector.connect(context),
                            onConnected: () => context.push('/home'),
                          );
                    },
                    child: const Text(
                      'Sign in with Wallet',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Gap(16),
                  if (connectionState != WalletConnectionState.disconnected)
                    CaptionText(transactionStateToString(connectionState)),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(AppConstant.aboutThisProjectUrl));
                      },
                      child: const Text('About'),
                    ),
                    const Gap(16),
                    DropdownButton(
                      value: flavor,
                      focusColor: Colors.transparent,
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(
                          value: Flavor.mainnet,
                          enabled: false,
                          child: Text('Mainnet(Not yet)'),
                        ),
                        DropdownMenuItem(
                          value: Flavor.testnet,
                          child: Text('Testnet(Goerli)'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(flavorProvider.notifier).update((state) => value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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
