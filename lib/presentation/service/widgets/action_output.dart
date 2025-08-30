import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../application/l10n/app_localizations.dart';
import 'package:upnped/upnped.dart';
import 'package:xml/xml.dart';

import 'action_output_dialog.dart';
import 'labeled_field.dart';

class ActionOutput extends StatelessWidget {
  final List<Argument> outputs;
  final Map<String, String> values;

  const ActionOutput({
    Key? key,
    required this.outputs,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            i18n.output,
            style: theme.titleLarge,
          ),
          ...outputs.map(
            (x) => ArgumentOutput(
              name: x.name,
              value: values[x.name],
            ),
          ),
        ],
      ),
    );
  }
}

class ArgumentOutput extends StatelessWidget {
  final String name;
  final String? value;

  const ArgumentOutput({
    Key? key,
    required this.name,
    this.value,
  }) : super(key: key);

  get text => LineSplitter().convert(value ?? '').join('');

  String label(BuildContext context) => value == null
      ? AppLocalizations.of(context)!.unknownValue(name)
      : AppLocalizations.of(context)!.knownValue(name, value!);

  String ParseText(String text) {
    if (text.startsWith('<?xml')) {
      final xml = XmlDocument.parse(text);
      return xml.toXmlString(pretty: true);
    } else {
      return text;
    }
  }

  void _showFullText(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => ActionOutputDialog(
        text: ParseText(text),
        propertyName: name,
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextStyle style) {
    final field = LabeledField(
      title: ExcludeSemantics(
        child: Text(
          name,
          style: style,
        ),
      ),
      child: ExcludeSemantics(
        child: TextField(
          controller: TextEditingController(
            text: text,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          enabled: false,
          readOnly: true,
          maxLines: 1,
        ),
      ),
    );

    if (_hasTextOverflowed(
      text,
      style,
      maxWidth: MediaQuery.of(context).size.width,
    )) {
      return GestureDetector(
        onTap: () => _showFullText(context),
        child: field,
      );
    }

    return field;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label(context),
      child: _buildTextField(
        context,
        Theme.of(context).textTheme.titleMedium!,
      ),
    );
  }
}

bool _hasTextOverflowed(
  String text,
  TextStyle style, {
  double minWidth = 0,
  double maxWidth = double.infinity,
  int maxLines = 1,
}) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(
      minWidth: minWidth,
      maxWidth: maxWidth,
    );

  return painter.didExceedMaxLines;
}
