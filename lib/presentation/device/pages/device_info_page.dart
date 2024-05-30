import 'package:upnped/upnped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceInfoPage extends StatelessWidget {
  final DeviceDescription device;

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
            subtitle: Text(device.manufacturer),
            onTap: device.manufacturerUrl == null
                ? null
                : () => launchUrl(
                      device.manufacturerUrl!,
                      mode: LaunchMode.externalApplication,
                    ),
            trailing: device.manufacturerUrl == null
                ? null
                : Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(i18n.modelName),
            subtitle: Text(device.modelName),
            onTap: device.modelUrl == null
                ? null
                : () => launchUrl(device.modelUrl!,
                    mode: LaunchMode.externalApplication),
            trailing:
                device.modelUrl == null ? null : Icon(Icons.chevron_right),
          ),
          if (device.modelNumber != null)
            ListTile(
              title: Text(i18n.modelNumber),
              subtitle: Text(device.modelNumber!),
            ),
          if (device.modelDescription != null)
            ListTile(
              title: Text(i18n.modelDescription),
              subtitle: Text(device.modelDescription!),
            ),
          if (device.serialNumber != null)
            ListTile(
              title: Text(i18n.serialNumber),
              subtitle: Text(device.serialNumber!),
            )
        ],
      ),
    );
  }
}
