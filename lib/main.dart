import 'package:altair/application/altair_main.dart';
import 'package:altair/logger.dart';
import 'package:altair/usecase/ethereum_connector.vm.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureMain();
  final theGreetingFacadeContractAddress = await loadTheGreetingFacadeContractAddress();
  logger.info(
    '🟢 The Greeting Facade Contract Address loaded: $theGreetingFacadeContractAddress',
  );
  runApp(
    ProviderScope(
      overrides: [
        theGreetingFacadeContractAddressProvider.overrideWithValue(
          theGreetingFacadeContractAddress,
        ),
      ],
      child: const AltairApp(),
    ),
  );
}
