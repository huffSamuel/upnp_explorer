import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/device.dart';
import '../../../infrastructure/upnp/ssdp_response_message.dart';

class DevicePageArguments {
  final Device device;
  final SSDPResponseMessage message;

  DevicePageArguments(this.device, this.message);
}

class DevicePage extends StatelessWidget {
  final Device device;
  final SSDPResponseMessage message;

  const DevicePage({
    Key? key,
    required this.device,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    Widget? fab;

    if (device.presentationUrl != null) {
      fab = FloatingActionButton(
        tooltip: i18n.openPresentationInBrowser,
        onPressed: () {
          launchUrl(
            device.presentationUrl!,
            mode: LaunchMode.externalApplication,
          );
        },
        child: Icon(
          Icons.open_in_browser_rounded,
        ),
      );
    }

    return Scaffold(
      floatingActionButton: fab,
      appBar: AppBar(
        title: Text(
          device.friendlyName,
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text('Open in browser'),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                launchUrl(
                  message.location,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
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
              ),
            if (device.serviceList.services.isNotEmpty)
              ListTile(
                title: Text(i18n.servicesN(device.serviceList.services.length)),
                subtitle: Text(
                  device.serviceList.services
                      .take(3)
                      .map(
                        (x) => x.serviceId.serviceId,
                      )
                      .join(i18n.listSeparator),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Application.router!.navigateTo(
                  context,
                  Routes.serviceList,
                  routeSettings: RouteSettings(arguments: device.serviceList),
                ),
              ),
            if (device.deviceList.devices.isNotEmpty)
              ListTile(
                title: Text(i18n.devicesN(device.deviceList.devices.length)),
                subtitle: Text(
                  device.deviceList.devices
                      .take(3)
                      .map(
                        (x) => x.deviceType.type,
                      )
                      .join(i18n.listSeparator),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Application.router!.navigateTo(
                  context,
                  Routes.deviceList,
                  routeSettings: RouteSettings(arguments: device.deviceList),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
