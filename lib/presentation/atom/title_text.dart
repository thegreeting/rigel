import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.value, {
    super.key,
  });

  final String value;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: platformThemeData<TextStyle>(
        context,
        material: (data) => data.textTheme.titleMedium!,
        cupertino: (data) => data.textTheme.navTitleTextStyle,
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
