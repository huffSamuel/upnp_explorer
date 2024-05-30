import 'package:upnped/upnped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/routing/routes.dart';
import 'device_page.dart';

class SubDevicesPage extends StatelessWidget {
  final Device device;
  final Uri deviceLocation;

  const SubDevicesPage({
    super.key,
    required this.device,
    required this.deviceLocation,
  });

  void _onDeviceTapped(BuildContext context, Device device) {
    Navigator.of(context).push(
      makeRoute(
        context,
        DevicePage(
          device: device,
          deviceLocation: deviceLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    List<Widget> body;

    if (device.devices.length == 0) {
      body = [
        Center(child: Text(i18n.nothingHere)),
      ];
    } else {
      body = List.from(device.devices.map(
        (device) {
          return ListTile(
            title: Text(device.description.deviceType.deviceType),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _onDeviceTapped(context, device),
          );
        },
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ),
    );
  }
}
