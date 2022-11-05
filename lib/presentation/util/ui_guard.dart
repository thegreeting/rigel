import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/widgets.dart';

// Return true when the error is not handled.
Future<bool> easyUIGuard(
  BuildContext context,
  Future<bool> Function() callback, {
  required String message,
}) async {
  unawaited(
    showAlertDialog<void>(
      context: context,
      title: message,
      barrierDismissible: false,
    ),
  );
  final ok = await callback();
  Navigator.of(context, rootNavigator: true).pop();
  return ok;
}
