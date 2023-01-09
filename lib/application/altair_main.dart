import 'package:altair/application/config/color_scheme.dart';
import 'package:altair/application/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/flavor.provider.dart';
import 'altair_route.dart';

class AltairApp extends ConsumerWidget {
  const AltairApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = ref.watch(flavorProvider);
    configureRigel(flavor);
    return MaterialApp.router(
      title: 'The Greeting',
      debugShowCheckedModeBanner: App.isTestnet,
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
