import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/presentation/device/pages/device_page.dart';
import 'package:upnp_explorer/presentation/device/widgets/device_image.dart';
import 'package:upnp_explorer/presentation/device/widgets/status_dot.dart';
import 'package:upnp_explorer/presentation/service/pages/action_page.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/routing/routes.dart';

class DeviceExpansionTile extends StatelessWidget {
  final Device device;

  const DeviceExpansionTile({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context)!.open,
      child: Stack(children: [
        ExpansionTile(
          leading: DeviceImage(
            icons: device.description.iconList,
            deviceIp: device.notify?.location,
          ),
          title: Text(
            device.description.friendlyName,
          ),
          subtitle: device.notify == null
              ? null
              : Text(device.notify!.location!.host.toString()),
          trailing: device.notify == null
              ? null
              : IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () => Navigator.of(context).push(
                    makeRoute(
                      context,
                      DevicePage(
                        device: device,
                        deviceLocation: device.notify!.location!,
                      ),
                    ),
                  ),
                ),
          children: [
            ...device.services
                .map((service) => ServiceExpansionTile(service: service)),
            ...device.devices.map((x) => DeviceExpansionTile(device: x)),
          ],
        ),
        if (device.notify != null)
          StatusDot(
            stream: device.isActive,
          ),
      ]),
    );
  }
}

class ServiceExpansionTile extends StatelessWidget {
  final Service service;

  const ServiceExpansionTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(service.document.serviceId.serviceId),
      leading: Icon(Icons.account_tree_outlined),
      children: [
        ...service.description!.actions.map(
          (x) {
            return ListTile(
              title: Text(x.name),
              leading: Icon(Icons.sync_alt),
              onTap: () => Navigator.of(context).push(
                makeRoute(
                  context,
                  ActionPage(
                    action: x,
                    stateTable: service.description!.serviceStateTable,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
