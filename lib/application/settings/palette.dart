import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryPurple = Color(0xFF982649);
const _primaryPurpleDark = Color(0xFF521427);

class AppTheme {
  static ThemeData dark(
    ColorScheme? scheme,
    VisualDensity visualDensity,
  ) {
    final effectiveScheme = scheme ??
        ColorScheme.fromSeed(
          seedColor: _primaryPurpleDark,
          brightness: Brightness.dark,
        );

    return _theme(
      effectiveScheme,
      visualDensity,
    );
  }

  static ThemeData light(
    ColorScheme? scheme,
    VisualDensity visualDensity,
  ) {
    final effectiveScheme = scheme ??
        ColorScheme.fromSeed(
          seedColor: _primaryPurple,
          brightness: Brightness.light,
        );

    return _theme(
      effectiveScheme,
      visualDensity,
    );
  }

  static ThemeData _theme(
    ColorScheme scheme,
    VisualDensity visualDensity,
  ) {
    final effectiveScheme = scheme.harmonized();

    final theme = ThemeData.from(
      useMaterial3: true,
      colorScheme: effectiveScheme,
    ).copyWith(
      visualDensity: visualDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: effectiveScheme.primary,
        foregroundColor: effectiveScheme.onPrimary,
      ),
    );

    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        bodySmall: theme.textTheme.bodySmall!.copyWith(
          fontFamily: GoogleFonts.sourceCodePro().fontFamily,
        ),
      ),
    );
  }
}
