import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../packages/upnp/upnp.dart';

class DeviceInfoPage extends StatelessWidget {
  final DeviceAggregate device;

  const DeviceInfoPage({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(i18n.manufacturer),
            subtitle: Text(device.document.manufacturer),
            onTap: device.document.manufacturerUrl == null
                ? null
                : () => launchUrl(
                      device.document.manufacturerUrl!,
                      mode: LaunchMode.externalApplication,
                    ),
            trailing: device.document.manufacturerUrl == null
                ? null
                : Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(i18n.modelName),
            subtitle: Text(device.document.modelName),
            onTap: device.document.modelUrl == null
                ? null
                : () => launchUrl(device.document.modelUrl!,
                    mode: LaunchMode.externalApplication),
            trailing: device.document.modelUrl == null
                ? null
                : Icon(Icons.chevron_right),
          ),
          if (device.document.modelNumber != null)
            ListTile(
              title: Text(i18n.modelNumber),
              subtitle: Text(device.document.modelNumber!),
            ),
          if (device.document.modelDescription != null)
            ListTile(
              title: Text(i18n.modelDescription),
              subtitle: Text(device.document.modelDescription!),
            ),
          if (device.document.serialNumber != null)
            ListTile(
              title: Text(i18n.serialNumber),
              subtitle: Text(device.document.serialNumber!),
            )
        ],
      ),
    );
  }
}
