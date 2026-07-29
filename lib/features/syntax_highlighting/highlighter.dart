import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class XmlHighlighter {
  static HighlighterTheme? _darkTheme;
  static HighlighterTheme? _lightTheme;

  static Future<Highlighter> forTheme(ThemeData theme) async {
    if (theme.brightness == Brightness.dark) {
      var darkTheme = _darkTheme ??= await HighlighterTheme.loadDarkTheme();

      return Highlighter(
        language: 'html',
        theme: darkTheme,
      );
    }

    var lightTheme = _lightTheme ??= await HighlighterTheme.loadLightTheme();
    return Highlighter(
      language: 'html',
      theme: lightTheme,
    );
  }
}
