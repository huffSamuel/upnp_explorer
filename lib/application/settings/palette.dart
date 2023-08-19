import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'options.dart';

Color? _resolveSelectedColor(Set<MaterialState> states, Color color) {
  if (states.contains(MaterialState.disabled)) {
    return null;
  }

  if (states.contains(MaterialState.selected)) {
    return color;
  }

  return null;
}

class Palette {
  static final Palette _palette = Palette._internal();
  static Palette get instance => _palette;

  Palette._internal();

  static ThemeData buildLightTheme(ColorScheme? scheme) {
    return _applyCommon(
      ThemeData.from(
        colorScheme: scheme ??
            ColorScheme.fromSeed(
              seedColor: Palette.instance.primaryPurple,
            ),
      ),
    );
  }

  static ThemeData buildDarkTheme(ColorScheme? scheme) {
    return _applyCommon(
      ThemeData.from(
        colorScheme: scheme ??
            ColorScheme.fromSeed(
              seedColor: Palette.instance.primaryPurpleDark,
              brightness: Brightness.dark,
            ),
      ),
    );
  }

  static ThemeData _applyCommon(ThemeData themeData) {
    return themeData.copyWith(
      textTheme: themeData.textTheme.copyWith(
        bodySmall: themeData.textTheme.bodySmall!.copyWith(
          fontFamily: GoogleFonts.sourceCodePro().fontFamily,
        ),
      ),
      switchTheme: themeData.switchTheme.copyWith(
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(
              states, themeData.colorScheme.secondary.withOpacity(0.3)),
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(
            states,
            themeData.colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  final primaryPurple = Color(0xFF982649);
  final primaryPurpleDark = Color(0xFF521427);
}
