import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/routing/routes.dart';
import '../../pages/device_page.dart';
import '../device_image.dart';
import '../status_dot.dart';

class DeviceListItem extends StatelessWidget {
  final Device device;

  const DeviceListItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context)!.open,
      child: Stack(children: [
        ListTile(
          leading: DeviceImage(
            icons: device.description.iconList,
            deviceIp: device.notify!.location!,
          ),
          title: Text(
            device.description.friendlyName,
          ),
          subtitle: Text(device.notify!.location!.host.toString()),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              makeRoute(
                context,
                DevicePage(
                  device: device,
                  deviceLocation: device.notify!.location!,
                ),
              ),
            );
          },
        ),
        StatusDot(
          stream: device.isActive,
        ),
      ]),
    );
  }
}
