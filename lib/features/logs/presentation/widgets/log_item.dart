import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';
import 'package:upnp_explorer/features/logs/presentation/widgets/event_content_preview.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/my_icon.dart';
import 'package:upnped/upnped.dart';

import 'timestamp.dart';

class LogItem extends StatelessWidget {
  final VoidCallback onTap;
  final NetworkEvent event;

  const LogItem({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();
    IconData icon = Icons.device_unknown;
    Widget title = Container();
    Widget subtitle = Container();

    if (event.type == 'M-SEARCH') {
      icon = Icons.call_made;
      title = Text(
        i18n.msearchSent,
        style: TextTheme.of(context).titleMedium!.copyWith(
              fontSize: 16,
              letterSpacing: -.25,
            ),
      );
      subtitle = Text(i18n.ssdpMulticastDiscovery,
          style: TextTheme.of(context).bodyMedium!.copyWith(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w500,
              letterSpacing: -.4));
    } else if (event.type == 'NOTIFY') {
      icon = Icons.call_received;
      title = Text(i18n.notifyReceived,
        style: TextTheme.of(context).titleMedium!.copyWith(
              fontSize: 16,
              letterSpacing: -.25,
            ),
      );
      subtitle = Text(
        i18n.fromAddress(event.from!),
        style: TextTheme.of(context).bodyMedium!.copyWith(
            color: Theme.of(context).disabledColor,
            fontWeight: FontWeight.w500,
            letterSpacing: -.4),
      );
    } else {
      final t = event.type.split(' ')[1];
      icon = t == 'GET' ? Icons.download : Icons.upload;

      title = Text(
        i18n.httpRequest(t),
        style: TextTheme.of(context).titleMedium!.copyWith(
              fontSize: 16,
              letterSpacing: -.25,
            ),
      );
      subtitle = subtitle = Text(
        i18n.toAddress(event.to!),
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
                    Theme.of(context).appBarTheme.backgroundColor!, color, 3),
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
          EventContentPreview(event: event)
        ],
      ),
    );
  }
}
