import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import 'devices_card.dart';

class DefaultDeviceImage extends StatelessWidget {
  final DeviceType? deviceType;

  const DefaultDeviceImage({super.key, this.deviceType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Icon(
        deviceType == null
            ? Icons.device_unknown
            : mapDeviceIcon(deviceType!.uri),
        size: 32,
        color: theme.colorScheme.outlineVariant,
      ),
    );
  }
}
