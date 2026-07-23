import 'package:flutter/material.dart';

class MyCustomColors extends ThemeExtension<MyCustomColors> {
  final Color? brandSuccess;
  final Color? onSuccess;

  MyCustomColors({this.brandSuccess, this.onSuccess});
  
  @override
  ThemeExtension<MyCustomColors> copyWith({
    Color? brandSuccess,
    Color? onSuccess,
  }) {
    return MyCustomColors(brandSuccess: brandSuccess ?? brandSuccess, onSuccess: onSuccess ?? onSuccess);
  }

  @override
  ThemeExtension<MyCustomColors> lerp(covariant ThemeExtension<MyCustomColors>? other, double t) {
    if (other is! MyCustomColors) {
      return this;
    }

    return MyCustomColors(
      brandSuccess: Color.lerp(brandSuccess, other.brandSuccess, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
    );
  }
}

class PrecisionObserverTheme {
  // Color Palette Constants
  static const Color _primary = Color(0xFF00435a);
  static const Color _primaryContainer = Color(0xFF005c7a);
  static const Color _secondaryContainer = Color(0xFFD6E5EC);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _surfaceContainerLow = Color(0xFFF2F4F5);
  static const Color _surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color _surfaceContainerHigh = Color(0xFFE6E8E9);
  static const Color _surfaceContainerHighest = Color.fromARGB(255, 209, 212, 213);

  static const Color _onSurface = Color(0xFF191C1D);
  static const Color _outlineVariant = Color(0xFFBFC8CE);
  static const Color _tertiary = Color(0xFF00463D);
  static const Color _error = Color(0xFFBA1A1A);
  static const Color _errorContainer = Color(0xFFFFB4AB);

  static const Color success = Color.fromARGB(255, 1, 135, 30);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _surface,
      primaryColor: _primary,
      
      extensions: [
        MyCustomColors(
          brandSuccess: success,
          onSuccess: Color.fromARGB(255, 222, 237, 226)
        )
      ],

      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: _primary,
        onPrimary: Colors.white,
        primaryContainer: _primaryContainer,
        onPrimaryContainer: Colors.white,
        secondary: _primary,
        onSecondary: Colors.white,
        secondaryContainer: _secondaryContainer,
        surfaceContainerHighest: _surfaceContainerHighest,
        onSecondaryContainer: _primary,
        tertiary: _tertiary,
        onTertiary: Colors.white,
        error: _error,
        errorContainer: _errorContainer,
        onError: Colors.white,
        surface: _surface,
        onSurface: _onSurface,
        surfaceContainerLow: _surfaceContainerLow,
        surfaceContainerHigh: _surfaceContainerHigh,
        outlineVariant: _outlineVariant,
      ),

      // Typography (Mapping Space Grotesk to Display/Headlines and Inter to Body/Labels)
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: _onSurface,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: _onSurface,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: _onSurface,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Space Grotesk',
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: _onSurface,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: _onSurface,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.0, // 0.875rem workhorse for IP/MAC addresses
          fontWeight: FontWeight.normal,
          color: _onSurface,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.0, // 0.6875rem for metadata/timestamps
          fontWeight: FontWeight.w500,
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

      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          color: _primary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        )
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

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _primary,
      ),

      // Elevated Button Theme (Primary to PrimaryContainer Gradient fallback/fill)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
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
