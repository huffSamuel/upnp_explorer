import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const notQuiteWhite = const Color(0xf8f7f6);

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
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: brightness)
          .harmonized(),
    );

    final e = theme.copyWith(
      visualDensity: visualDensity,
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 4,
      ),
      textTheme: theme.textTheme.copyWith(
        bodySmall: theme.textTheme.bodySmall!.copyWith(
          fontFamily: GoogleFonts.sourceCodePro().fontFamily,
        ),
      ),
    );

    return e;
  }
}
