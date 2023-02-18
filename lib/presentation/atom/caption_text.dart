import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../application/config/color_scheme.dart';

class CaptionText extends StatelessWidget {
  const CaptionText(
    this.value, {
    super.key,
    this.style,
    this.textAlign,
  });

  final String value;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: platformThemeData<TextStyle>(
        context,
        material: (data) => data.textTheme.bodySmall!.merge(style),
        cupertino: (data) => data.textTheme.textStyle
            .copyWith(
              fontSize: 14,
              color: AppPalette.scheme.onSurfaceVariant.maybeResolve(context),
            )
            .merge(style),
      ),
      textAlign: textAlign,
      child: Text(value),
    );
  }
}
