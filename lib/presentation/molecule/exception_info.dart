import 'package:altair/domain/entity/exception/general_exception.entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../application/config/status.dart';
import '../../domain/entity/exception/util/recoverable_exception.entity.dart';
import '../../util/array.extention.dart';
import '../atom/simple_info.dart';

class ExceptionInfo extends StatelessWidget {
  const ExceptionInfo({
    super.key,
    this.title,
    required this.message,
    this.buttonText,
    this.onPressed,
  });

  final String? title;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: SimpleInfo(
              title: title,
              message: message,
            ),
          ),
          const SizedBox(height: 16),
          if (onPressed != null)
            PlatformElevatedButton(
              onPressed: onPressed,
              child: Text(
                buttonText ?? 'Retry',
              ),
            ),
        ],
      ),
    );
  }
}

class RecoverableExceptionInfo extends StatelessWidget {
  const RecoverableExceptionInfo(
    this.exception, {
    super.key,
    this.stackTrace,
    this.onPressed,
  });

  const RecoverableExceptionInfo.withStackTrace(
    this.exception,
    this.stackTrace, {
    super.key,
    this.onPressed,
  });

  final Object exception;
  final StackTrace? stackTrace;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final exceptionOrError = exception;

    final recoverableException = (() {
      if (exceptionOrError is RecoverableException) {
        return exceptionOrError;
      } else {
        return GeneralException(
          failureReason: exceptionOrError.toString(),
        );
      }
    })();

    var message = recoverableException.localizedRecoverySuggestion(context);
    if (App.isDebugMode) {
      message += '\n${stackTrace?.toString() ?? ''}';
    }
    return ExceptionInfo(
      title: recoverableException.localizedFailureReason(context),
      message: message,
      buttonText: recoverableException.localizedRecoveryOptions(context).firstOrNull,
      onPressed: onPressed,
    );
  }
}
