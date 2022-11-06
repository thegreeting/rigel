import 'package:altair/application/config/color_scheme.dart';
import 'package:altair/usecase/ethereum_connector.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

class EthereumAddressText extends ConsumerWidget {
  const EthereumAddressText(this.addressOrName, {super.key});

  final String addressOrName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAddress = addressOrName.startsWith('0x');

    return TextButton(
      onPressed: () async {
        if (isAddress) {
          await launchUrl(
            Uri.parse('https://goerli.etherscan.io/address/$addressOrName'),
          );
        } else {}
      },
      child: FutureBuilder(
        future: isAddress
            ? getENSNameWithAddress(EthereumAddress.fromHex(addressOrName))
            : Future.value(addressOrName.substring(0, 6)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!,
              style: TextStyle(
                color: AppPalette.scheme.primary.maybeResolve(context),
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return Text(addressOrName.substring(0, 6));
          }
        },
      ),
    );
  }
}
