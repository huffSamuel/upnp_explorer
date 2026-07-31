import 'package:flutter/material.dart';
import '../../extension/color.dart';
import 'custom_colors.dart';

class FontFamily {
  static const roboto = 'Roboto';
  static const sourceCodePro = 'Source Code Pro';
  static const spaceGrotesk = 'Space Grotesk';
}

class AppTheme {
  static ThemeData dark({bool oled = false}) {
    Color surface = oled ? Colors.black : Color(0xFF101415);
    Color surfaceContainerLowest = Color(0xFF0B0F10).darken(oled ? 0.05 : 0);
    Color surfaceContainerLow =
        Color.fromARGB(255, 21, 28, 28).darken(oled ? 0.05 : 0);
    Color surfaceContainerHigh =
        Color.fromARGB(255, 32, 34, 35).darken(oled ? 0.05 : 0);
    Color surfaceContainerHighest =
        Color.fromARGB(255, 49, 50, 51).darken(oled ? 0.05 : 0);

    const Color onSurface = Color(0xFFE1E3E4);

    const Color primary = Color.fromARGB(255, 91, 134, 157);
    const Color onPrimary = Color(0xFF003548);
    const Color primaryContainer = Color(0xFF005C7A);
    const Color onPrimaryContainer = Color(0xFF90D3F5);

    const Color tertiary = Color(0xFF83D6C4);
    const Color error = Color(0xFFFFB4AB);

    final extensions = [
      MyCustomColors(
          brandSuccess: Color.fromARGB(255, 17, 105, 32),
          onSuccess: Color.fromARGB(255, 164, 202, 171)),
    ];

    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: primary,
      onSecondary: onPrimary,
      secondaryContainer: Color.fromARGB(255, 38, 52, 58),
      onSecondaryContainer: onSurface,
      tertiary: tertiary,
      onTertiary: onSurface,
      error: error,
      onError: Colors.black,
      surface: surface,
      onSurface: onSurface,
      outlineVariant: Color.fromARGB(255, 31, 52, 66),
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      scaffoldBackgroundColor: scheme.surface,
      primaryColor: scheme.primary,
      extensions: extensions,
      colorScheme: scheme,

      fontFamily: FontFamily.roboto,
      textTheme: _text(scheme),

      // App Bar Theme (Transparent with surface tint and editorial headline)
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: FontFamily.spaceGrotesk,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        iconTheme: IconThemeData(
          color: onSurface,
          size: 24.0,
        ),
      ),

      // Card Theme (No 1px solid borders, rounded xl / 12px)
      cardTheme: CardThemeData(
        color: surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated Button Theme (Primary fill with dark mode ambient shadow)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 0,
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.4),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontFamily: FontFamily.roboto,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static TextTheme _text(ColorScheme scheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: FontFamily.spaceGrotesk,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: scheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontFamily: FontFamily.spaceGrotesk,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: scheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamily.spaceGrotesk,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: FontFamily.spaceGrotesk,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontFamily.roboto,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: scheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamily.roboto,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: scheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontFamily: FontFamily.roboto,
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
    );
  }

  static ThemeData light() {
    const Color primary = Color(0xFF00435a);
    const Color primaryContainer = Color(0xFF005c7a);
    const Color secondaryContainer = Color(0xFFD6E5EC);
    const Color surface = Color(0xFFFFFFFF);
    const Color surfaceContainerLow = Color(0xFFF2F4F5);
    const Color surfaceContainerLowest = Color(0xFFFFFFFF);
    const Color surfaceContainerHigh = Color(0xFFE6E8E9);
    const Color surfaceContainerHighest = Color.fromARGB(255, 209, 212, 213);

    const Color onSurface = Color(0xFF191C1D);
    const Color outlineVariant = Color(0xFFBFC8CE);
    const Color tertiary = Color(0xFF00463D);
    const Color error = Color(0xFFBA1A1A);
    const Color errorContainer = Color(0xFFFFB4AB);
    const Color success = Color.fromARGB(255, 1, 135, 30);

    final scheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryContainer,
      onPrimaryContainer: Colors.white,
      secondary: primary,
      onSecondary: Colors.white,
      secondaryContainer: secondaryContainer,
      surfaceContainerHighest: surfaceContainerHighest,
      onSecondaryContainer: primary,
      tertiary: tertiary,
      onTertiary: Colors.white,
      error: error,
      errorContainer: errorContainer,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh,
      outlineVariant: outlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: surface,
      primaryColor: primary,

      extensions: [
        MyCustomColors(
            brandSuccess: success,
            onSuccess: Color.fromARGB(255, 222, 237, 226))
      ],

      colorScheme: scheme,

      // Typography (Mapping Space Grotesk to Display/Headlines and Inter to Body/Labels)
      fontFamily: FontFamily.roboto,
      textTheme: _text(scheme),

      // App Bar Theme (Transparent with surface tint and editorial headline)
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: FontFamily.spaceGrotesk,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        iconTheme: IconThemeData(
          color: onSurface,
          size: 24.0,
        ),
      ),

      listTileTheme: ListTileThemeData(
          titleTextStyle: TextStyle(
        color: primary,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      )),

      // Card Theme (No 1px solid borders, rounded xl / 12px)
      cardTheme: CardThemeData(
        color: surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.zero,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primary,
      ),

      // Elevated Button Theme (Primary to PrimaryContainer Gradient fallback/fill)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: const Color.fromRGBO(25, 28, 29, 0.06),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
