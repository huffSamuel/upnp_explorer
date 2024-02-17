import 'package:flutter/material.dart';

import '../../../simple_upnp/src/upnp.dart';

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
          ? const Icon(Icons.device_unknown)
          : Image.network(
              Uri(
                scheme: deviceIp.scheme,
                host: deviceIp.host,
                port: deviceIp.port,
                path: icons.first.url.toString(),
              ).toString(),
            ),
    );
  }
}
