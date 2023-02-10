import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/device/device.dart';
import '../../service/bloc/command_bloc.dart';
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
      label: S.of(context).open,
      child: ListTile(
        leading: DeviceImage(
          icons: device.description.device.iconList,
          deviceIp: device.ipAddress,
        ),
        title: Text(
          device.description.device.friendlyName,
        ),
        subtitle: Text(device.ipAddress.toString()),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          BlocProvider.of<CommandBloc>(context).add(SetDevice(device));

          Application.router!.navigateTo(
            context,
            Routes.deviceDocument,
            routeSettings: RouteSettings(
              arguments: DevicePageArguments(
                device.description.device,
                device.discoveryResponse,
                xml: device.description.xml,
              ),
            ),
          );
        },
      ),
    );
  }
}
