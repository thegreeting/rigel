import 'package:altair/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

const bool isTestLab = bool.fromEnvironment('firebase.test.lab');

Future<void> configureMain() async {
  timeago.setDefaultLocale('en_short');

  if (kDebugMode) {
    logger
      ..info('Configure MAIN for DEBUG MODE')
      ..fine('🔥 Firebase Analytics is disabled in DEBUG MODE');
  }

  if (isTestLab) {
    logger.fine('🔥 Firebase Analytics is disabled in TEST LAB');
  }
}
