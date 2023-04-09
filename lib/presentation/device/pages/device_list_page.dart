import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/domain/upnp/upnp.dart';

import '../../../application/routing/routes.dart';
import '../../core/page/app_page.dart';
import 'device_page.dart';

class DeviceListPage extends StatelessWidget {
  final Uri deviceLocation;
  final List<DeviceAggregate> devices;

  const DeviceListPage({
    Key? key,
    required this.devices,
    required this.deviceLocation,
  }) : super(key: key);

  void _onDeviceTapped(BuildContext context, DeviceAggregate device) {
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
    final children = List<Widget>.of(
      devices.map(
        (device) {
          return ListTile(
            title: Text(device.document.deviceType.deviceType),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _onDeviceTapped(context, device),
          );
        },
      ),
    );

    return AppPage(
      title: Text(AppLocalizations.of(context)!.devices),
      children: children,
    );
  }
}
