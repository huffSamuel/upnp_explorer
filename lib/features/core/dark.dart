import 'package:flutter/material.dart';
import 'light.dart';

class PrecisionObserverDarkTheme {
  // Color Palette Constants (Dark Theme)
  static const Color _surface = Color(0xFF101415);
  static const Color _surfaceContainerLowest = Color(0xFF0B0F10);
  static const Color _surfaceContainerHigh = Color.fromARGB(255, 32, 34, 35);
  static const Color _surfaceContainerHighest = Color.fromARGB(255, 49, 50, 51);

  static const Color _onSurface = Color(0xFFE1E3E4);
  static const Color _outlineVariant = Color(0xFF40484D);

  static const Color _primary = Color.fromARGB(255, 91, 134, 157);
  static const Color _onPrimary = Color(0xFF003548);
  static const Color _primaryContainer = Color(0xFF005C7A);
  static const Color _onPrimaryContainer = Color(0xFF90D3F5);

  static const Color _secondaryContainer = Color(0xFF3B494F);

  static const Color _tertiary = Color(0xFF83D6C4);
  static const Color _error = Color(0xFFFFB4AB);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _surface,
      primaryColor: _primary,

      extensions: [
        MyCustomColors(
            brandSuccess: Color.fromARGB(255, 17, 105, 32),
            onSuccess: Color.fromARGB(255, 164, 202, 171))
      ],

      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: _primary,
        onPrimary: _onPrimary,
        primaryContainer: _primaryContainer,
        onPrimaryContainer: _onPrimaryContainer,
        secondary: _primary,
        onSecondary: _onPrimary,
        secondaryContainer: _secondaryContainer,
        onSecondaryContainer: _onSurface,
        tertiary: _tertiary,
        onTertiary: _onSurface,
        error: _error,
        onError: Colors.black,
        surface: _surface,
        onSurface: _onSurface,
        outlineVariant: _outlineVariant,
        surfaceContainerHigh: _surfaceContainerHigh,
        surfaceContainerHighest: _surfaceContainerHighest,
      ),

      // Typography (Space Grotesk for Headings, Inter for Body/Labels)
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 32.0, // 2rem
          fontWeight: FontWeight.bold,
          height: 1.2,
          color: _onSurface,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 20.0, // 1.25rem
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: _onSurface,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.0, // 0.875rem workhorse for IP/MAC addresses
          fontWeight: FontWeight.normal,
          height: 1.5,
          color: _onSurface,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.0, // 0.6875rem for metadata/timestamps
          fontWeight: FontWeight.w500,
          height: 1.4,
          letterSpacing: 0.02,
          color: _onSurface,
        ),
      ),

      // App Bar Theme (Transparent with surface tint and editorial headline)
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: _onSurface,
        ),
        iconTheme: IconThemeData(
          color: _onSurface,
          size: 24.0,
        ),
      ),

      // Card Theme (No 1px solid borders, rounded xl / 12px)
      cardTheme: CardThemeData(
        color: _surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated Button Theme (Primary fill with dark mode ambient shadow)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _onPrimary,
          elevation: 0,
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.4),
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
