import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      label: AppLocalizations.of(context)!.open,
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

          Navigator.of(context).push(
            makeRoute(
              context,
              DevicePage(
                device: device.description.device,
                deviceLocation: device.discoveryResponse.location,
                xml: device.description.xml,
              ),
            ),
          );
        },
      ),
    );
  }
}
