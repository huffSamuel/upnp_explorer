import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogDetailsDialog extends StatelessWidget {
  final String text;
  final String title;

  const LogDetailsDialog({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final _controller = ScrollController();

    return AlertDialog(
      title: Text(title),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Scrollbar(
          controller: _controller,
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text)).then((_) {
              Navigator.of(context).pop();
            });
          },
          child: Text(i18n.copy),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(i18n.close),
        ),
      ],
    );
  }
}
