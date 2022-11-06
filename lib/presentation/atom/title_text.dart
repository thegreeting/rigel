import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.value, {
    super.key,
    this.style,
  });

  final String value;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: platformThemeData<TextStyle>(
        context,
        material: (data) => data.textTheme.titleMedium!,
        cupertino: (data) => data.textTheme.navTitleTextStyle,
      ).merge(style),
      child: Text(
        value,
        style: TextStyle(
          fontSize: style?.fontSize ?? 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
