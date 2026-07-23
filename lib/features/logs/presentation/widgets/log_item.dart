import 'package:flutter/material.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/my_icon.dart';
import 'package:upnped/upnped.dart';

import 'timestamp.dart';

class _ContentPreview extends StatelessWidget {
  final NetworkEvent event;

  const _ContentPreview({required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String? content = null;

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
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w400),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ));
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
    IconData icon = Icons.device_unknown;
    Widget title = Container();
    Widget subtitle = Container();

    if (event.type == 'M-SEARCH') {
      icon = Icons.call_made;
      title = Text(
        'M-SEARCH Sent',
        style: TextTheme.of(context).titleMedium!.copyWith(
              fontSize: 16,
              letterSpacing: -.25,
            ),
      );
      subtitle = Text('SSDP Multicast Discovery',
          style: TextTheme.of(context).bodyMedium!.copyWith(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w500,
              letterSpacing: -.4));
    } else if (event.type == 'NOTIFY') {
      icon = Icons.call_received;
      title = Text(
        'NOTIFY Received',
        style: TextTheme.of(context).titleMedium!.copyWith(
              fontSize: 16,
              letterSpacing: -.25,
            ),
      );
      subtitle = Text(
        'From: ${event.from}',
        style: TextTheme.of(context).bodyMedium!.copyWith(
            color: Theme.of(context).disabledColor,
            fontWeight: FontWeight.w500,
            letterSpacing: -.4),
      );
    } else {
      final t = event.type.split(' ')[1];
      icon = t == 'GET' ? Icons.download : Icons.upload;

      title = Text(
        '$t Request',
        style: TextTheme.of(context).titleMedium!.copyWith(
              fontSize: 16,
              letterSpacing: -.25,
            ),
      );
      subtitle = subtitle = Text(
        'To: ${event.to}',
        style: TextTheme.of(context).bodyMedium!.copyWith(
            color: Theme.of(context).disabledColor,
            fontWeight: FontWeight.w500,
            letterSpacing: -.4),
      );
    }

    final isError = event is HttpEvent && (event as HttpEvent).isError();
    final theme = Theme.of(context);
    final color = isError ? theme.colorScheme.error : theme.colorScheme.primary;

    return MyCard(
      highlight: color,
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyIcon(
                size: 20,
                icon: icon,
                color: color,
                backgroundColor: ElevationOverlay.applySurfaceTint(
                    Theme.of(context).appBarTheme.backgroundColor!,
                    color,
                    3),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title, subtitle],
              ),
              Spacer(),
              Timestamp(time: event.time),
            ],
          ),
          const SizedBox(height: 8),
          _ContentPreview(event: event)
        ],
      ),
    );
  }
}
