import 'package:flutter/material.dart';
import '../../../application/l10n/app_localizations.dart';
import 'package:upnped/upnped.dart';

class LogDirection extends StatelessWidget {
  final NetworkEventDirection direction;

  const LogDirection({super.key, required this.direction});

  IconData get _icon {
    if (direction == NetworkEventDirection.incoming) {
      return Icons.call_received;
    }

    return Icons.call_made;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Row(children: [
      Icon(_icon, size: 18, color: Theme.of(context).colorScheme.onSurface),
      const SizedBox(width: 4),
      Text(i18n.direction(direction.name)),
    ]);
  }
}
