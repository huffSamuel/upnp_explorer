import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

class EventContentPreview extends StatelessWidget {
  final NetworkEvent event;

  const EventContentPreview({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String? content;

    final e = event;
    if (e is HttpEvent && e.responseBody != null) {
      content = e.responseBody!;
    } else {
      // TODO: Update upnped library with SsdpEvent type for
      // content
      content = (e as dynamic).content;
    }

    if (content == null) {
      return const SizedBox();
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(
        top: 4,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      width: double.infinity,
      child: Text(
        content.trim(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: 'Source Code Pro',
            ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
