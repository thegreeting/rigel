import 'package:altair/logger.dart';
import 'package:altair/util/flavor.provider.dart';
import 'package:flutter/foundation.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

import 'application/config/status.dart';

const bool isTestLab = bool.fromEnvironment('firebase.test.lab');

Future<void> configureMain() async {
  timeago.setDefaultLocale('en_short');

  final initialFlavor = loadFlavor();
  App.flavor = initialFlavor;

  if (kDebugMode) {
    logger.info('Configure MAIN for DEBUG MODE');
  }
}
