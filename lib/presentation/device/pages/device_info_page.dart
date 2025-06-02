import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/l10n/app_localizations.dart';
import '../../core/page/app_page.dart';

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
          ),
        if (device.presentationUrl != null || notify?.location != null)
          Divider(),
        if (device.presentationUrl != null)
          _ListButton(
            label: Text(i18n.openPresentationInBrowser),
            onPressed: _openPresentationUrl,
            icon: Icon(Icons.open_in_browser),
          ),
        if (notify?.location != null)
          _ListButton(
            label: Text(i18n.openInBrowser),
            onPressed: () => launchUrl(notify!.location!),
            icon: Icon(Icons.open_in_browser),
          ),
      ],
    );
  }
}

class _ListButton extends StatelessWidget {
  final Widget label;
  final VoidCallback onPressed;
  final Widget icon;

  const _ListButton({
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
        child: ElevatedButton.icon(
          label: label,
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
