import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

import '../../logger.dart';
import '../../util/flavor.provider.dart';

mixin App {
  static bool isReleaseMode = kReleaseMode;
  static bool isDebugMode = kDebugMode;
  static String version = '0.0.0';
  static String buildNumber = '0';
  static Flavor flavor = Flavor.mainnet;
  static bool isTestnet = false;
}

Future<void> configureRigel(Flavor flavor) async {
  final packageInfo = await PackageInfo.fromPlatform();
  App.version = packageInfo.version;
  App.buildNumber = packageInfo.buildNumber;
  logger.info('App.version: ${App.version}(${App.buildNumber})');
  App.flavor = flavor;
  App.isTestnet = App.flavor == Flavor.testnet;
  logger.info('App.flavor: ${App.flavor}');
}
