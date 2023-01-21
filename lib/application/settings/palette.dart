import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upnp_explorer/application/ioc.dart';

import '../device.dart';
import 'options.dart';

class Palette {
  static final Palette _palette = Palette._internal();
  static Palette get instance => _palette;

  Palette._internal();

  final gray = Color(0xFF7C8483);

  final primary = Color(0xFF71A2B6);
  final secondary = Color(0xFF60B2E5);

  final bigDipOruby = Color(0xFF982649);
  final blackBean = Color(0xFF4C0000);
  final accent = Color(0xFF53F4FF);
  final olivine = Color(0xFF9CB380);

  ThemeData darkTheme(Options options) {
    final theme = ThemeData.dark();

    return theme.copyWith(
      useMaterial3: options.material3,
      visualDensity: options.visualDensity,
      colorScheme: ColorScheme.fromSeed(
        seedColor: olivine,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        color: blackBean,
      ),
      textTheme: theme.textTheme.copyWith(
        caption: GoogleFonts.sourceCodeProTextTheme().bodyMedium!.copyWith(
          color: Colors.white,
        ),
      ),
      listTileTheme: theme.listTileTheme.copyWith(
        textColor: Colors.white
      )
    );
  }

  ThemeData lightTheme(Options options) {
    final theme = ThemeData.light();

    return theme.copyWith(
      useMaterial3: options.material3,
      visualDensity: options.visualDensity,
      colorScheme: ColorScheme.fromSeed(
        seedColor: secondary,
        brightness: Brightness.light,
      ),
      textTheme: theme.textTheme.copyWith(
        caption: GoogleFonts.sourceCodeProTextTheme().bodyMedium,
      ),
    );
  }
}
