import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entity/exception/user_activity_exception.entity.dart';
import '../../domain/entity/exception/util/recoverable_exception.entity.dart';

typedef OptionSelectedCallback = void Function(Object error);

// Return true when the error is not handled.
Future<bool> noticeableGuard(
  BuildContext context,
  Future<void> Function() callback, {
  OptionSelectedCallback? onFirstOptionSelected,
  OptionSelectedCallback? onError,
  bool disableAutoHandle = false,
}) async {
  try {
    await callback();
    return true;
  } on RecoverableException catch (e) {
    onError?.call(e);
    final ok = await showOkCancelAlertDialog(
      context: context,
      title: e.localizedFailureReason(context),
      message: e.localizedRecoverySuggestion(context),
      okLabel: e.localizedRecoveryOptions(context).first,
    );
    if (ok == OkCancelResult.ok) {
      onFirstOptionSelected?.call(e);

      if (disableAutoHandle) {
        return false;
      }

      if (e is NeedToAuthenticate) {
        context.go('/');
      }
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    onError?.call(e);
    final ok = await showOkAlertDialog(
      context: context,
      message: e.toString(),
    );
    if (ok == OkCancelResult.ok) {
      onFirstOptionSelected?.call(e);
    }
  }
  return false;
}
