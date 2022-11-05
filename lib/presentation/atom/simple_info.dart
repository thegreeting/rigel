import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../application/config/color_scheme.dart';
import 'title_text.dart';

class SimpleInfo extends StatelessWidget {
  const SimpleInfo({
    super.key,
    this.title,
    required this.message,
    this.enableCentering = false,
  });

  final String message;
  final String? title;
  final bool enableCentering;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            TitleText(
              title!,
            ),
            const SizedBox(height: 8)
          ],
          Text(
            message,
            style: platformThemeData(
              context,
              material: (theme) => theme.textTheme.bodyLarge?.copyWith(
                color: AppPalette.scheme.onSurfaceVariant.maybeResolve(context),
              ),
              cupertino: (theme) => theme.textTheme.textStyle.copyWith(
                color: AppPalette.scheme.onSurfaceVariant.maybeResolve(context),
              ),
            ),
            textAlign: enableCentering ? TextAlign.center : TextAlign.start,
          ),
        ],
      ),
    );
  }
}
