import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../atom/caption_text.dart';

class LoadingInfo extends StatelessWidget {
  const LoadingInfo({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 88, minWidth: 88),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlatformCircularProgressIndicator(
              cupertino: (_, __) => CupertinoProgressIndicatorData(
                radius: 12,
              ),
            ),
            const SizedBox(height: 8),
            if (message != null)
              CaptionText(
                message!,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
