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

  final primaryPurple = Color(0xFF982649);
  final primaryPurpleDark = Color(0xFF521427);
  final c = Color.fromARGB(255, 233, 210, 217);
  final c2 = Color.fromARGB(255, 136, 100, 111);

  TextStyle get _caption => GoogleFonts.sourceCodeProTextTheme().bodyMedium!;

  ThemeData darkTheme(Options options) {
    final theme = ThemeData.dark(
      useMaterial3: options.material3,
    );

    return theme.copyWith(
      visualDensity: options.visualDensity,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFBB8897),
        onPrimary: Colors.white,
        primaryContainer: Color(0xff7c2941),
        onPrimaryContainer: Color(0xffffd9df),
        secondary: Color(0xffe4bdc3),
        onSecondary: Color(0xff43292f),
        secondaryContainer: Color(0xff5b3f45),
        onSecondaryContainer: Color(0xffffd9df),
        tertiary: Color(0xffecbe91),
        onTertiary: Color(0xff462a09),
        tertiaryContainer: Color(0xff60401d),
        onTertiaryContainer: Color(0xffffdcbd),
        error: Color(0xffffb4ab),
        onError: Color(0xff690005),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xffffb4ab),
        background: Color(0xff201a1b),
        onBackground: Color(0xffece0e0),
        surface: Color(0xff201a1b),
        onSurface: Color(0xffece0e0),
        surfaceVariant: Color(0xff524345),
        onSurfaceVariant: Color(0xffd6c2c4),
        outline: Color(0xff9f8c8f),
        inverseSurface: Color(0xffece0e0),
        onInverseSurface: Color(0xff352f30),
        inversePrimary: Color(0xff9a4058),
        surfaceTint: Color(0xffffb1c1),
      ),
      appBarTheme: AppBarTheme(
        color: primaryPurpleDark,
        foregroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: theme.textTheme.copyWith(
        caption: _caption.copyWith(
          color: Colors.white,
        ),
      ),
      listTileTheme: theme.listTileTheme.copyWith(textColor: Colors.white),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(states, c),
        ),
      ),
      switchTheme: theme.switchTheme.copyWith(
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(states, c2),
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(states, c),
        ),
      ),
    );
  }

  ThemeData lightTheme(Options options) {
    final theme = ThemeData.light(
      useMaterial3: options.material3,
    );

    return theme.copyWith(
      visualDensity: options.visualDensity,
      colorScheme: ColorScheme(
        primary: primaryPurple,
        onPrimary: Colors.white,
        primaryContainer: Color(0xff982649),
        onPrimaryContainer: Color(0xff3f0016),
        secondary: Color(0xff75565c),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffffd9df),
        onSecondaryContainer: Color(0xff2b151a),
        tertiary: Color(0xff7a5732),
        onTertiary: Color(0xFFffffff),
        tertiaryContainer: Color(0xffffdcbc),
        onTertiaryContainer: Color(0xff2c1700),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        background: Color(0xfffffbff),
        onBackground: Color(0xff201a1b),
        surface: Color(0xfffffbff),
        onSurface: Color(0xff201a1b),
        surfaceVariant: Color(0xfff3dde0),
        onSurfaceVariant: Color(0xff524345),
        outline: Color(0xff847375),
        inverseSurface: Color(0xff362f30),
        onInverseSurface: Color(0xfffaeeee),
        inversePrimary: Color(0xffffb1c0),
        surfaceTint: Color(0xffa83254),
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        color: primaryPurple,
        foregroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: theme.textTheme.copyWith(
        caption: _caption,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(states, c2),
        ),
      ),
      switchTheme: theme.switchTheme.copyWith(
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(states, c2),
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => _resolveSelectedColor(states, c),
        ),
      ),
    );
  }
}
