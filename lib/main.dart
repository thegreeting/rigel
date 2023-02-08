import 'package:altair/application/altair_main.dart';
import 'package:altair/util/flavor.provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureMain();
  final initialFlavor = loadFlavor();
  runApp(
    ProviderScope(
      overrides: [
        flavorProvider.overrideWith((_) => initialFlavor),
      ],
      child: const AltairApp(),
    ),
  );
}
