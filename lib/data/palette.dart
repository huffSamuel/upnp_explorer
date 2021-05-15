import 'package:flutter/material.dart';

import 'options.dart';

class Palette {
  static final Palette _palette = Palette._internal();
  static Palette get instance => _palette;

  Palette._internal();

  final gray = Color(0xFF7C8483);

  final primary = Color(0xFF71A2B6);
  final secondary = Color(0xFF60B2E5);

  final red = Color(0xFF982649);
  final darkRed = Color(0xFF4C0000);
  final accent = Color(0xFF53F4FF);

  ThemeData _common(ThemeData data, Options options) {
    return data.copyWith(
      visualDensity: options.visualDensity,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: data.accentColor,
        ),
      ),
    );
  }

  ThemeData darkTheme(Options options) {
    return _common(ThemeData.dark(), options).copyWith(
      primaryColor: darkRed,
      accentColor: accent,
      buttonColor: accent,
    );
  }

  ThemeData lightTheme(Options options) {
    return _common(ThemeData.light(), options).copyWith(
      primaryColor: red,
      accentColor: secondary,
      buttonColor: secondary,
    );
  }
}
