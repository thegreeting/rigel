import 'package:altair/application/altair_main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureMain();

  runApp(
    const ProviderScope(
      child: AltairApp(),
    ),
  );
}
