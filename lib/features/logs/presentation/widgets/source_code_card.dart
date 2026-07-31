import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../extension/build_context.dart';

import '../../../core/presentation/widgets/section_header.dart';
import 'detail_section_card.dart';
import 'source_code.dart';

class SourceCodeCard extends StatelessWidget {
  final Widget title;
  final String sourceCode;

  const SourceCodeCard({
    super.key,
    required this.title,
    required this.sourceCode,
  });

  void _onCopy() {
    Clipboard.setData(ClipboardData(text: sourceCode));
  }

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: SectionHeader(
        icon: Icon(Icons.code_outlined),
        title: title,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 0, top: 8.0, right: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SourceCode(text: sourceCode),
            const SizedBox(height: 16),
            Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.copy),
                  onPressed: _onCopy,
                  label: Text(context.i18n().copy),
                )),
          ],
        ),
      ),
    );
  }
}
