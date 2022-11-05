import 'package:altair/application/config/color_scheme.dart';
import 'package:flutter/material.dart';

import 'altair_route.dart';

class AltairApp extends StatelessWidget {
  const AltairApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'The Greeting',
      debugShowCheckedModeBanner: false,
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
