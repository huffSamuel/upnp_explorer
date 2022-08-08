import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/application.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/device.dart';

class DeviceDocumentPage extends StatelessWidget {
  final Device device;

  const DeviceDocumentPage({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? fab;

    if (device.presentationUrl != null) {
      fab = FloatingActionButton(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Manufacturer'),
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
              title: Text('Model Name'),
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
                title: Text('Model Number'),
                subtitle: Text(device.modelNumber!),
              ),
            if (device.modelDescription != null)
              ListTile(
                title: Text('Model Description'),
                subtitle: Text(device.modelDescription!),
              ),
            if (device.serialNumber != null)
              ListTile(
                title: Text('Serial Number'),
                subtitle: Text(device.serialNumber!),
              ),
            if (device.serviceList.services.isNotEmpty)
              ListTile(
                title: Text('Services (${device.serviceList.services.length})'),
                subtitle: Text(
                  device.serviceList.services
                      .take(3)
                      .map(
                        (x) => x.serviceId.serviceId,
                      )
                      .join(', '),
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
                title: Text('Devices (${device.deviceList.devices.length})'),
                subtitle: Text(
                  device.deviceList.devices
                      .take(3)
                      .map(
                        (x) => x.deviceType.type,
                      )
                      .join(', '),
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
