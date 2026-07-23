import 'package:flutter/material.dart';
import '../../../core/presentation/widgets/my_card.dart';
import 'external_url_field.dart';
import 'information_field.dart';
import 'package:upnped/upnped.dart';

class DeviceInformationCard extends StatelessWidget {
  final DeviceDescription device;

  const DeviceInformationCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MyCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 12),
              Text(
                'Device Information',
                style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -.3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ExternalUrlField(
            modelName: device.manufacturer,
            modelUrl: device.manufacturerUrl,
            label: 'manufacturer',
          ),
          ExternalUrlField(
            label: 'model name',
            modelName: device.modelName,
            modelUrl: device.modelUrl,
          ),
          InformationField(label: 'model number', value: device.modelNumber),
          InformationField(
              label: 'model description', value: device.modelDescription),
          InformationField(label: 'serial number', value: device.serialNumber),
        ],
      ),
    );
  }
}
