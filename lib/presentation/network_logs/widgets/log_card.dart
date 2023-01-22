import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../domain/network_logs/direction.dart';
import '../../../domain/network_logs/protocol.dart';
import '../../core/widgets/model_binding.dart';
import 'log_details_dialog.dart';
import 'traffic_filter.dart';

String _firstThreeLines(String text) {
  return text.split('\n').take(3).join('\n');
}

class LogCard extends StatelessWidget {
  final Direction direction;
  final Protocol protocol;
  final String origin;
  final String text;
  final DateTime time;
  final void Function(TrafficFilter) onFilter;

  const LogCard({
    Key? key,
    required this.direction,
    required this.protocol,
    required this.origin,
    required this.text,
    required this.time,
    required this.onFilter,
  }) : super(key: key);

  void _filter(TrafficFilter filter, bool selected) {
    final newFilter = selected ? filter: TrafficFilter.all();

    onFilter(newFilter);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final filter = ModelBinding.of<TrafficFilter>(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    label: Text(i18n.direction(direction)),
                    selected: filter == TrafficFilter.direction(direction),
                    onSelected: (selected) {
                      final newFilter = selected
                          ? TrafficFilter.direction(direction)
                          : TrafficFilter.all();
            
                      onFilter(newFilter);
                    },
                  ),
                  FilterChip(
                    label: Text(i18n.protocol(protocol)),
                    selected: filter == TrafficFilter.protocol(protocol),
                    onSelected: (selected) =>
                        _filter(TrafficFilter.protocol(protocol), selected),
                  ),
                  FilterChip(
                    label: Text(origin),
                    selected: filter == TrafficFilter.origin(origin),
                    onSelected: (selected) =>
                        _filter(TrafficFilter.origin(origin), selected),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: GestureDetector(
                child: Text(_firstThreeLines(text), style: Theme.of(context).textTheme.caption),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => LogDetailsDialog(
                      time: time,
                      direction: direction,
                      text: text,
                      origin: origin,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
