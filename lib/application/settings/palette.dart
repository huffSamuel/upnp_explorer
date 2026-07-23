import 'package:flutter/material.dart';

const notQuiteWhite = const Color(0xf8f7f6);
const sourceCodePro = 'Source Code Pro';

const primaryLight = const Color(0x005C7A);
const secondary = const Color(0x526066);
const tertiary = const Color(0x006B5D);

class AppTheme {
  static ThemeData dark(
    ColorScheme? scheme,
    VisualDensity visualDensity,
  ) {
    return _theme2(
      scheme?.primary ?? notQuiteWhite,
      visualDensity,
      Brightness.dark,
    );
  }

  static ThemeData light(
    ColorScheme? scheme,
    VisualDensity visualDensity,
  ) {
    return _theme2(
      scheme?.primary ?? notQuiteWhite,
      visualDensity,
      Brightness.light,
    );
  }

  static ThemeData _theme2(
    Color seed,
    VisualDensity visualDensity,
    Brightness brightness,
  ) {
    final theme = ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryLight,
        secondary: secondary,
        tertiary: tertiary,
        brightness: brightness,
      ),
    );

    final e = theme.copyWith(
      visualDensity: visualDensity,
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: theme.colorScheme.surfaceContainerLow,
        iconTheme: IconThemeData(color: theme.colorScheme.primary)
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
        selectedItemColor: theme.colorScheme.primary
      ),
      scaffoldBackgroundColor: theme.colorScheme.surfaceContainerLow,
      textTheme: theme.textTheme.copyWith(
        bodySmall: theme.textTheme.bodySmall!.copyWith(
          fontFamily: sourceCodePro,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (brightness == Brightness.dark) {
      return e.copyWith(
          colorScheme: e.colorScheme.copyWith(
        surface: e.colorScheme.surfaceBright,
      ));
    }

    return e;
  }
}
