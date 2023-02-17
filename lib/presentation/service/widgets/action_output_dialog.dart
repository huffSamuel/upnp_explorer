import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActionOutputDialog extends StatelessWidget {
  final String text;
  final String propertyName;

  const ActionOutputDialog(
      {super.key, required this.text, required this.propertyName});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final _controller = ScrollController();

    return AlertDialog(
      title: Text(propertyName),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 100,
                  content: Container(
                    height: 15.0,
                    child: Center(
                      child: Text(i18n.copied),
                    ),
                  ),
                ),
              );
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
