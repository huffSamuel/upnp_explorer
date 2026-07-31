import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../extension/build_context.dart';
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
    final i18n = context.i18n();

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(child: Text(i18n.deviceDetails)),
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
