import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/device/device.dart';
import '../pages/device_page.dart';
import 'device-image.dart';

class DeviceListItem extends StatelessWidget {
  final UPnPDevice device;

  const DeviceListItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: S
          .of(context)
          .discoveredDevice(device.description.device.friendlyName),
      child: ListTile(
        leading: DeviceImage(
          icons: device.description.device.iconList.icons,
          deviceIp: device.ipAddress,
        ),
        title: Text(
          device.description.device.friendlyName,
        ),
        subtitle: Text(device.ipAddress.toString()),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Application.router!.navigateTo(
            context,
            Routes.deviceDocument,
            routeSettings: RouteSettings(
              arguments: DevicePageArguments(
                device.description.device,
                device.discoveryResponse,
              ),
            ),
          );
        },
      ),
    );
  }
}
