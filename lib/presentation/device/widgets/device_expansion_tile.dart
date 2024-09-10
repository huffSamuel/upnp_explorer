import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/routing/routes.dart';
import '../../service/pages/action_page.dart';
import '../pages/device_info_page.dart';
import 'device_image.dart';
import 'leading_icon_builder.dart';
import 'status_dot.dart';

EdgeInsets _tileInsets(int depth) {
  return EdgeInsets.only(left: depth * 20);
}

class _IconAboutButton extends StatelessWidget {
  final Device device;

  const _IconAboutButton({required this.device});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_outline),
      tooltip: AppLocalizations.of(context)!.aboutThisDevice,
      onPressed: () => Navigator.of(context).push(
        makeRoute(
          context,
          DeviceInfoPage(
            device: device.description,
            notify: device.notify!,
          ),
        ),
      ),
    );
  }
}

class _FilledAboutButton extends StatelessWidget {
  final Device device;

  const _FilledAboutButton({required this.device});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: Text(AppLocalizations.of(context)!.about),
      onPressed: () => Navigator.of(context).push(
        makeRoute(
          context,
          DeviceInfoPage(
            device: device.description,
            notify: device.notify!,
          ),
        ),
      ),
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
          childrenPadding: _tileInsets(depth),
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
              if (device.notify != null)
                MediaQuery.of(context).size.width < 780
                    ? _IconAboutButton(device: device)
                    : _FilledAboutButton(device: device),
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

class ServiceExpansionTile extends StatelessWidget {
  final Service service;
  final int depth;

  const ServiceExpansionTile({
    super.key,
    required this.service,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: _tileInsets(depth),
      title: Text(service.document.serviceId.serviceId),
      leading: SizedBox(
        height: 40,
        width: 40,
        child: Icon(Icons.account_tree_outlined),
      ),
      children: [
        if (service.description!.actions.isEmpty)
          ListTile(
            title: Text(AppLocalizations.of(context)!.noActionsForThisService),
            leading: LeadingIconBuilder(
              builder: (context) => Icon(Icons.warning_amber_rounded),
            ),
          ),
        ...service.description!.actions.map(
          (x) {
            return ListTile(
              title: Text(x.name),
              leading: LeadingIconBuilder(
                builder: (context) => Icon(Icons.sync_alt),
              ),
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
