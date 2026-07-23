import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/l10n/app_localizations.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../widgets/device_info_card.dart';
import '../widgets/device_title_card.dart';
import '../widgets/devices_card.dart';
import '../widgets/services_card.dart';

class DeviceInfoPage extends StatelessWidget {
  final Device device;

  const DeviceInfoPage({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(child: Text('Device Details')),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          children: [
            HeadlineCard(
              device: device.description,
              notify: device.notify,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: DeviceInformationCard(device: device.description),
            ),
            if (device.services.isNotEmpty)
              ServicesCard(services: device.services),
            if (device.devices.isNotEmpty) DevicesCard(devices: device.devices)
          ],
        ),
      ),
    );
  }
}

