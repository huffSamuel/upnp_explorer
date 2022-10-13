import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../domain/network_logs/traffic.dart';

final timeFormat = DateFormat('HH:mm:ss.SSS');

class LogDetailsDialog extends StatelessWidget {
  final TrafficDirection direction;
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
    final i18n = S.of(context);
    final _controller = ScrollController();

    final timeString = timeFormat.format(time);

    return AlertDialog(
      title: Text(S.of(context).direction(direction)),
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
                if (direction == TrafficDirection.incoming)
                  Text(S.of(context).receivedAt(timeString)),
                if (direction == TrafficDirection.outgoing)
                  Text(S.of(context).sentAt(timeString)),
                SizedBox(height: 4.0),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(height: 4.0),
                Text(
                  text,
                  style: Theme.of(context).textTheme.caption,
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
