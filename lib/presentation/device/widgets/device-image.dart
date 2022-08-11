import 'package:flutter/material.dart';

import '../../../infrastructure/upnp/device.dart';

class DeviceImage extends StatelessWidget {
  final List<DeviceIcon> icons;
  final Uri deviceIp;

  const DeviceImage({
    Key? key,
    required this.icons,
    required this.deviceIp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: icons.isEmpty
          ? Icon(Icons.device_unknown)
          : Image.network(
              deviceIp.toString() + icons.first.url.toString(),
            ),
    );
  }
}
