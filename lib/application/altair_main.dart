import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../usecase/ethereum_connector.vm.dart';
import '../util/flavor.provider.dart';
import 'altair_route.dart';
import 'config/color_scheme.dart';
import 'config/config.dart';

class AltairApp extends ConsumerWidget {
  const AltairApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = ref.watch(flavorProvider);
    final isTestnet = ref.watch(isTestnetProvider);
    configureRigel(flavor);
    return MaterialApp.router(
      title: 'The Greeting',
      debugShowCheckedModeBanner: isTestnet,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: AppPalette.scheme,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
