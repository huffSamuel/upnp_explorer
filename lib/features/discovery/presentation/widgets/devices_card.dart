import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../core/presentation/widgets/my_icon.dart';
import '../../../core/util/upnp.dart';
import '../pages/device_info_page.dart';
import 'item_list_card.dart';

class DevicesCard extends StatelessWidget {
  final List<Device> devices;

  const DevicesCard({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ItemListCard(
      items: devices,
      itemBuilder: (c, i) => ListTile(
        visualDensity: VisualDensity.compact,
        title: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            i.description.friendlyName,
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
        leading: MyIcon(
          backgroundColor: theme.colorScheme.surfaceContainerHigh,
          color: theme.colorScheme.primary,
          icon: mapDeviceIcon(i.description.deviceType.uri),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DeviceInfoPage(device: i),
            ),
          );
        },
        trailing: Icon(Icons.chevron_right),
      ),
      title: Row(children: [
        Icon(
          Icons.account_tree,
          color: theme.colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          'Child Devices',
          style: TextTheme.of(context).bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: -.3,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ]),
    );
  }
}

IconData mapDeviceIcon(String schema) {
  final icon = getDeviceIcon(schema);

  if (icon != null) {
    return icon;
  }

  if (!isWellKnown(schema)) {
    return Icons.extension_outlined;
  }

  print('Add $schema to well known devices');

  return Icons.schema_outlined;
}

class WellKnownDevices {
  static const String internetGateway =
      'urn:schemas-upnp-org:device:InternetGatewayDevice:1';
  static const String wanDevice = 'urn:schemas-upnp-org:device:WANDevice:1';
  static const String wanConnection =
      'urn:schemas-upnp-org:device:WANConnectionDevice:1';
  static const String mediaServer = 'urn:schemas-upnp-org:device:MediaServer:1';
  static const String mediaRenderer =
      'urn:schemas-upnp-org:device:MediaRenderer:1';
  static const String binaryLight = 'urn:schemas-upnp-org:device:BinaryLight:1';
  static const String dimmerLight = 'urn:schemas-upnp-org:device:DimmerLight:1';
  static const String printer = 'urn:schemas-upnp-org:device:Printer:1';
  static const String scanner = 'urn:schemas-upnp-org:device:Scanner:1';
}

IconData? getDeviceIcon(String? deviceType) {
  switch (deviceType) {
    case WellKnownDevices.internetGateway:
    case WellKnownDevices.wanDevice:
    case WellKnownDevices.wanConnection:
      return Icons.router_outlined;
    case WellKnownDevices.mediaServer:
      return Icons.storage_outlined;
    case WellKnownDevices.mediaRenderer:
      return Icons.cast_outlined;
    case WellKnownDevices.binaryLight:
    case WellKnownDevices.dimmerLight:
      return Icons.lightbulb_outline;
    case WellKnownDevices.printer:
      return Icons.print_outlined;
    case WellKnownDevices.scanner:
      return Icons.scanner_outlined;
    default:
      return null;
  }
}
