import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import 'log_direction.dart';
import 'timestamp.dart';

class _ContentPreview extends StatelessWidget {
  final NetworkEvent event;

  const _ContentPreview({required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String content = '';

    final e = event;
    if (e is HttpEvent) {
      content = e.responseBody;
    } else if (e is MSearchEvent) {
      content = e.content;
    } else if (e is NotifyEvent) {
      content = e.content;
    }

    return Container(
      decoration: BoxDecoration(
        color: ElevationOverlay.applySurfaceTint(
          colorScheme.surface,
          colorScheme.secondary,
          1,
        ),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 1,
          color: ElevationOverlay.applySurfaceTint(
            colorScheme.surface,
            colorScheme.secondary,
            20,
          ),
        ),
      ),
      margin: const EdgeInsets.only(
        top: 4,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 6,
      ),
      width: double.infinity,
      child: Text(
        content.trim(),
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class LogItem extends StatelessWidget {
  final VoidCallback onTap;
  final NetworkEvent event;

  const LogItem({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        // HACK: This fixes tap target behavior for this element. Without this, tapping in the empty space won't do anything.
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Timestamp(time: event.time),
            Row(
              children: [
                Text(
                  event.type,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 6),
                LogDirection(direction: event.direction),
              ],
            ),
            if (event.from != null && event.from != '127.0.0.1')
              Text(event.from!),
            _ContentPreview(event: event),
          ],
        ),
      ),
    );
  }
}
