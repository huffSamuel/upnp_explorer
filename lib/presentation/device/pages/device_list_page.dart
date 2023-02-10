import 'package:flutter/material.dart';
import 'package:upnp_explorer/presentation/core/page/app_page.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';

class DeviceListPage extends StatelessWidget {
  final List<Device> devices;

  const DeviceListPage({
    Key? key,
    required this.devices,
  }) : super(key: key);

  void _onDeviceTapped(BuildContext context, Device device) {
    Application.router!.navigateTo(
      context,
      Routes.deviceDocument,
      routeSettings: RouteSettings(arguments: device),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>.of(
      devices.map(
        (device) {
          return ListTile(
            title: Text(
              device.deviceType.type,
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _onDeviceTapped(context, device),
          );
        },
      ),
    );

    return AppPage(
      title: Text(S.of(context).devices),
      children: children,
    );
  }
}
