import 'package:upnped/upnped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/routing/routes.dart';
import '../pages/device_page.dart';
import 'device_image.dart';

class DeviceListItem extends StatelessWidget {
  final UPnPDevice device;

  const DeviceListItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context)!.open,
      child: ListTile(
        leading: DeviceImage(
          icons: device.document.iconList,
          deviceIp: device.client.location!,
        ),
        title: Text(
          device.document.friendlyName,
        ),
        subtitle: Text(device.client.location!.host.toString()),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            makeRoute(
              context,
              DevicePage(
                device: device,
                deviceLocation: device.client.location!,
              ),
            ),
          );
        },
      ),
    );
  }
}
