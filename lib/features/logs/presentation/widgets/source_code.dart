import 'package:flutter/material.dart';

import '../../../syntax_highlighting/highlighter.dart';

class SourceCode extends StatelessWidget {
  final String text;

  const SourceCode({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface,
      ),
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Source Code Pro'),
        child: FutureBuilder(
            future: XmlHighlighter.forTheme(theme),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SizedBox();
              }

              if (!snapshot.hasData) {
                return SizedBox();
              }

              return Text.rich(snapshot.data!.highlight(text));
            }),
      ),
    );
  }
}
