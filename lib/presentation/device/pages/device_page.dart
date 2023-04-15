import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/packages/upnp/upnp.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/routing/routes.dart';
import '../../core/page/app_page.dart';
import '../../core/widgets/row_count.dart';
import 'device_list_page.dart';
import '../../service/pages/service_list_page.dart';

class DevicePageArguments {
  final DeviceAggregate device;

  DevicePageArguments(this.device);
}

class DevicePage extends StatelessWidget {
  final DeviceAggregate device;
  final Uri deviceLocation;

  const DevicePage({
    Key? key,
    required this.device,
    required this.deviceLocation,
  }) : super(key: key);

  _openPresentationUrl() {
    launchUrl(
      device.document.presentationUrl!,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return AppPage(
      title: Text(device.document.friendlyName),
      actions: [
        IconButton(
          tooltip: i18n.openPresentationInBrowser,
          icon: Icon(Icons.open_in_browser),
          onPressed: _openPresentationUrl,
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Text(i18n.openInBrowser),
            ),
          ],
          onSelected: (value) {
            if (value == 0) {
              launchUrl(
                deviceLocation,
                mode: LaunchMode.externalApplication,
              );
            }
          },
        ),
      ],
      children: [
        Padding(
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
                ),
              if (device.services.isNotEmpty)
                ListTile(
                  title: Text(i18n.services),
                  subtitle: RowCountOverflowed(
                    labels: List.from(
                      device.services
                          .map((x) => x.document.serviceId.serviceId),
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    makeRoute(
                      context,
                      ServiceListPage(
                        services: device.services,
                        deviceId: device.document.udn,
                      ),
                    ),
                  ),
                ),
              if (device.devices.isNotEmpty)
                ListTile(
                  title: Text(i18n.devicesN(device.devices.length)),
                  subtitle: Text(
                    device.devices
                        .take(3)
                        .map(
                          (x) => x.document.deviceType.deviceType,
                        )
                        .join(i18n.listSeparator),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    makeRoute(
                      context,
                      DeviceListPage(
                        devices: device.devices,
                        deviceLocation: deviceLocation,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
