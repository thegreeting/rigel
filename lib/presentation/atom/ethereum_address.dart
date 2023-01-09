import 'package:altair/application/config/color_scheme.dart';
import 'package:altair/usecase/ethereum_connector.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class EthereumAddressText extends ConsumerWidget {
  const EthereumAddressText(this.address, {super.key});

  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayAddressOrNameAsyncValue =
        ref.watch(walletDisplayAddressOrNameProviders(address));

    return TextButton(
      onPressed: () async {
        await launchUrl(
          Uri.parse(
            'https://goerli.etherscan.io/address/$address',
          ), // TODO(knaoe): mainnet support
        );
      },
      child: displayAddressOrNameAsyncValue.when(
        data: (addressOrName) {
          return Text(
            addressOrName,
            style: TextStyle(
              color: AppPalette.scheme.primary.maybeResolve(context),
              fontWeight: FontWeight.bold,
            ),
          );
        },
        loading: () => Text(buildDisplayAddressText(address)),
        error: (_, __) => Text(buildDisplayAddressText(address)),
      ),
    );
  }
}
