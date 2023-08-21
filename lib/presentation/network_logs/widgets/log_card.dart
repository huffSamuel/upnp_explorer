import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../packages/upnp/upnp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogCard extends StatelessWidget {
  final VoidCallback onTap;
  final NetworkMessage traffic;

  const LogCard({
    Key? key,
    required this.traffic,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                i18n.messageLog(
                  traffic.direction.name,
                  DateFormat('H:m:s:SSS').format(traffic.time),
                  traffic.messageType,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ElevationOverlay.applySurfaceTint(
                    colorScheme.surface,
                    colorScheme.surfaceTint,
                    10,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 1,
                    color: ElevationOverlay.applySurfaceTint(
                      colorScheme.surface,
                      colorScheme.surfaceTint,
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
                  traffic.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
