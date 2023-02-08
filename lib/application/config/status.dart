import 'package:flutter/foundation.dart';

mixin App {
  static bool isReleaseMode = kReleaseMode;
  static bool isDebugMode = kDebugMode;
  static String version = '0.0.0';
  static String buildNumber = '0';
}
