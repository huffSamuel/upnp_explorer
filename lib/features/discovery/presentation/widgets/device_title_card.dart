import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import 'device_image.dart';

class HeadlineCard extends StatelessWidget {
  final DeviceDescription device;
  final NotifyDiscovered? notify;

  const HeadlineCard({super.key, required this.device, this.notify});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
            ],
            transform: GradientRotation(-2.36)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 24,
            color: Color.fromRGBO(25, 28, 29, 0.04),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 32),
          IconTheme(
            data: IconThemeData(color: theme.colorScheme.outlineVariant),
            child: DeviceImage2(
              device: device,
              deviceIp: notify?.location,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: theme.colorScheme.outlineVariant.withAlpha(128),
                  ),
                ],
                color: theme.colorScheme.primaryFixedDim,
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              device.friendlyName,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 32,
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -.6,
                  ),
            ),
          ),
          if (notify != null)
            Text(
              notify!.location!.host,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 20,
                    color: theme.colorScheme.secondaryContainer,
                    letterSpacing: -.3,
                  ),
            ),
        ],
      ),
    );
  }
}
