import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:flutter/cupertino.dart' show CupertinoDynamicColor, CupertinoColors;

const _myDynamicOnPrimaryColor = CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.white,
  darkColor: CupertinoColors.white,
);

const _myDynamicPrimaryColor = CupertinoColors.activeGreen;

const _myDynamicOnSecondaryColor = CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.black,
  darkColor: CupertinoColors.black,
);
const _myDynamicSecondaryColor = CupertinoColors.systemTeal;

const _myDynamicOnSurfaceColor = CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.black,
  darkColor: CupertinoColors.white,
);

const _myDynamicSurfaceColor = CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.white,
  darkColor: CupertinoColors.black,
);

const _myDynamicOnBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.black,
  darkColor: CupertinoColors.white,
);

const _defaultColorScheme = ColorScheme.light(
  primary: _myDynamicPrimaryColor,
  secondary: _myDynamicSecondaryColor,
  surface: _myDynamicSurfaceColor,
  background: CupertinoColors.systemBackground,
  error: CupertinoColors.destructiveRed,
  onPrimary: _myDynamicOnPrimaryColor,
  onSecondary: _myDynamicOnSecondaryColor,
  onSurface: _myDynamicOnSurfaceColor,
  onSurfaceVariant: CupertinoColors.systemGrey,
  onBackground: _myDynamicOnBackgroundColor,
);

class AppPalette {
  AppPalette._();
  static const ColorScheme scheme = _defaultColorScheme;
  static const Color divider = CupertinoColors.systemGrey2;
  static const Color focus = CupertinoColors.systemGrey4;
  static const Color placeholder = CupertinoColors.systemGrey2;
  static const Color backgroundLevel1 = CupertinoColors.systemGrey6;
  static const Color backgroundLevel2 = CupertinoColors.systemGrey4;
}

class AppTheme extends StatelessWidget {
  const AppTheme({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final materialThemeData = ThemeData(
      colorScheme: _defaultColorScheme,
      useMaterial3: true,
      brightness: MediaQuery.of(context).platformBrightness,
    );
    return Theme(
      data: materialThemeData.copyWith(
        brightness: MediaQuery.of(context).platformBrightness,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: AppPalette.scheme.onBackground.maybeResolve(context),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: AppPalette.scheme.onBackground.maybeResolve(context),
          ),
          caption: TextStyle(
            color: AppPalette.scheme.onSurfaceVariant.maybeResolve(context),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppPalette.divider.maybeResolve(context),
        ),
        // CanvasColor is used for the background color of the pickers.
        canvasColor: AppPalette.backgroundLevel1.maybeResolve(context),
        listTileTheme: ListTileThemeData(
          iconColor: AppPalette.scheme.onBackground.maybeResolve(context),
          selectedColor: AppPalette.placeholder.maybeResolve(context),
        ),
      ),
      child: CupertinoTheme(
        data: const CupertinoThemeData(),
        child: child,
      ),
    );
  }
}

extension DynamicColor on Color {
  Color? maybeResolve(BuildContext context) {
    return CupertinoDynamicColor.maybeResolve(this, context);
  }
}
