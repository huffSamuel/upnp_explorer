import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/network_logs/direction.dart';

class LogDetailsDialog extends StatelessWidget {
  final Direction direction;
  final String? origin;
  final String text;
  final DateTime time;

  const LogDetailsDialog({
    Key? key,
    required this.direction,
    this.origin,
    required this.text,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final _controller = ScrollController();

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.direction(direction.name)),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Scrollbar(
          controller: _controller,
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(i18n.fromAddress(origin!)),
                SizedBox(height: 4.0),
                if (direction == Direction.incoming)
                  Text(AppLocalizations.of(context)!.receivedAt(time)),
                if (direction == Direction.outgoing)
                  Text(AppLocalizations.of(context)!.sentAt(time)),
                SizedBox(height: 4.0),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(height: 4.0),
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
