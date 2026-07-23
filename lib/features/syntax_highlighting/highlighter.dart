import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class XmlHighlighter {
  static late final Highlighter lightHighlighter;
  static late final Highlighter darkHighlighter;

  static forTheme(ThemeData theme){ 
    if (theme.brightness == Brightness.dark) {
      return darkHighlighter;
    }

    return lightHighlighter;
  }

  static initialize() async {
    await Highlighter.initialize([
      'html',
    ]);

    var lightTheme = await HighlighterTheme.loadLightTheme();
    lightHighlighter = Highlighter(
      language: 'html',
      theme: lightTheme,
    );

    // Load the default dark theme and create a highlighter.
    var darkTheme = await HighlighterTheme.loadDarkTheme();
    darkHighlighter = Highlighter(
      language: 'html',
      theme: darkTheme,
    );
  }
}
