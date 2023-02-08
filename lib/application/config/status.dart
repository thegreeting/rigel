import 'package:flutter/foundation.dart';

import '../../util/flavor.provider.dart';

mixin App {
  static bool isReleaseMode = kReleaseMode;
  static bool isDebugMode = kDebugMode;
  static String version = '0.0.0';
  static String buildNumber = '0';
  static Flavor flavor = Flavor.mainnet;
  static bool get isTestnet => App.flavor != Flavor.mainnet;
}
