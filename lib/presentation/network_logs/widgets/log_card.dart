import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/domain/upnp/upnp.dart';

import 'traffic_filter.dart';

class LogCard extends StatelessWidget {
  final MessageDirection direction;
  final MessageProtocol protocol;
  final DateTime time;
  final List<Widget> children;
  final void Function(TrafficFilter) onFilter;

  const LogCard({
    Key? key,
    required this.direction,
    required this.protocol,
    required this.time,
    required this.onFilter,
    required this.children,
  }) : super(key: key);

  void _filter(TrafficFilter filter, bool selected) {
    final newFilter = selected ? filter : TrafficFilter.all();

    onFilter(newFilter);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(i18n.direction(direction.name) +
                ' ' +
                i18n.protocol(protocol.name) +
                ' message'),
            Text(i18n.sentAt(time)),
            ...children,
            // Padding(
            //   padding: const EdgeInsets.only(left: 12.0),
            //   child: GestureDetector(
            //     child: Text(
            //       _firstThreeLines(text),
            //       style: Theme.of(context).textTheme.bodySmall,
            //     ),
            //     onTap: () {
            //       showDialog(
            //         context: context,
            //         builder: (context) => LogDetailsDialog(
            //           time: time,
            //           direction: direction,
            //           text: text,
            //           origin: origin,
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
