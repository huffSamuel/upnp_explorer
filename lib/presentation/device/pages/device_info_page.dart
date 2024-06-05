import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/presentation/core/page/app_page.dart';
import 'package:upnped/upnped.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceInfoPage extends StatelessWidget {
  final DeviceDescription device;
  final NotifyDiscovered? notify;

  const DeviceInfoPage({
    super.key,
    required this.device,
    this.notify,
  });

  _openPresentationUrl() {
    launchUrl(
      device.presentationUrl!,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return AppPage(
      title: Text(device.friendlyName),
      actions: [
        if (device.presentationUrl != null)
          IconButton(
            tooltip: i18n.openPresentationInBrowser,
            icon: Icon(Icons.open_in_browser),
            onPressed: _openPresentationUrl,
          ),
        if (notify?.location != null)
          IconButton(
              tooltip: i18n.openInBrowser,
              icon: Icon(Icons.file_open_outlined),
              onPressed: () {
                launchUrl(
                  notify!.location!,
                  mode: LaunchMode.externalApplication,
                );
              })
      ],
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
          trailing:
              device.manufacturerUrl == null ? null : Icon(Icons.chevron_right),
        ),
        ListTile(
          title: Text(i18n.modelName),
          subtitle: Text(device.modelName),
          onTap: device.modelUrl == null
              ? null
              : () => launchUrl(device.modelUrl!,
                  mode: LaunchMode.externalApplication),
          trailing: device.modelUrl == null ? null : Icon(Icons.chevron_right),
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
    );
  }
}
