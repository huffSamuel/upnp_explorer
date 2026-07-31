import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/_all.dart';

import '../../../../application/ioc.dart';
import '../../../../extension/color.dart';
import '../../../../extension/xml_document.dart';
import '../../services/highlight.dart';

class SourceCode extends StatelessWidget {
  final String text;

  const SourceCode({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final codeTheme =
        theme.brightness == Brightness.light ? githubTheme : githubDarkTheme;

    final background =
        HexColor.tryFromHex(codeTheme['root']?.backgroundColor) ??
            theme.colorScheme.surface;

    final parsed = XmlDocumentTry.parse(text);

    final effectiveText =
        parsed == null ? text : parsed.toXmlString(pretty: true);

    final highlighter = sl.get<HighlightService>();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: background,
      ),
      child: HighlightView(
        effectiveText,
        highlighter: highlighter.highlight,
        language: 'xml',
        theme: codeTheme,
      ),
    );
  }
}
