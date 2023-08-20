import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color? _resolveSelectedColor(Set<MaterialState> states, Color color) {
  if (states.contains(MaterialState.disabled)) {
    return null;
  }

  if (states.contains(MaterialState.selected)) {
    return color;
  }

  return null;
}

const _primaryPurple = Color(0xFF982649);
const _primaryPurpleDark = Color(0xFF521427);

class Palette {
  static final Palette _palette = Palette._internal();
  static Palette get instance => _palette;

  Palette._internal();

  static ThemeData makeTheme(
      ColorScheme? scheme, Brightness brightness, VisualDensity visualDensity) {
    return _applyCommon(
      ThemeData.from(
        useMaterial3: true,
        colorScheme: (scheme ??
                ColorScheme.fromSeed(
                  brightness: brightness,
                  seedColor: brightness == Brightness.dark
                      ? _primaryPurpleDark
                      : _primaryPurple,
                ))
            .harmonized(),
      ).copyWith(
        visualDensity: visualDensity,
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
}
