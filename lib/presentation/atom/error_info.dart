import 'package:flutter/widgets.dart';

import '../../application/config/color_scheme.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    this.error,
    this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPalette.scheme.error.maybeResolve(context),
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        error?.toString() ?? 'Unknown error',
        style: TextStyle(
          color: AppPalette.scheme.onError.maybeResolve(context),
        ),
      ),
    );
  }
}
