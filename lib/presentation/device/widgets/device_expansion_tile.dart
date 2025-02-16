import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/routing/routes.dart';
import '../../../application/l10n/app_localizations.dart';
import '../pages/device_info_page.dart';
import 'device_image.dart';
import 'service_expansion_tile.dart';
import 'status_dot.dart';
import 'tile_insets.dart';

class _AboutDeviceButton extends StatelessWidget {
  final Device device;

  const _AboutDeviceButton({
    required this.device,
  });

  void _navigateInfoPage(BuildContext context) => Navigator.of(context).push(
        makeRoute(
          context,
          DeviceInfoPage(
            device: device.description,
            notify: device.notify!,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (size.width < 780) {
      return IconButton(
        icon: Icon(Icons.info_outline),
        tooltip: AppLocalizations.of(context)!.aboutThisDevice,
        onPressed: () => _navigateInfoPage(context),
      );
    }

    return FilledButton(
      child: Text(AppLocalizations.of(context)!.about),
      onPressed: () => _navigateInfoPage(context),
    );
  }
}

class DeviceExpansionTile extends StatelessWidget {
  final Device device;
  final int depth;

  const DeviceExpansionTile({
    Key? key,
    required this.device,
    this.depth = 1,
  }) : super(key: key);

  Border get _noBorder => Border.all(color: Colors.transparent, width: 0);

  Border? get _tileBorder => depth == 1 ? _noBorder : null;

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      children: [
        ExpansionTile(
          shape: _tileBorder,
          collapsedShape: _tileBorder,
          childrenPadding: tileInsets(depth),
          leading: DeviceImage(
            icons: device.description.iconList,
            deviceIp: device.notify?.location,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.description.friendlyName,
                  ),
                  if (device.notify != null)
                    Text(device.notify!.location!.host.toString()),
                ],
              ),
              if (device.notify != null) _AboutDeviceButton(device: device),
            ],
          ),
          children: [
            ...device.services.map((x) => ServiceExpansionTile(
                  service: x,
                  depth: depth + 1,
                )),
            ...device.devices.map((x) => DeviceExpansionTile(
                  device: x,
                  depth: depth + 1,
                )),
          ],
        ),
        if (device.notify != null)
          StatusDot(
            stream: device.isActive,
          ),
      ],
    );

    if (depth == 1) {
      child = Card(child: child);
    }

    return Semantics(
      label: AppLocalizations.of(context)!.open,
      child: child,
    );
  }
}
