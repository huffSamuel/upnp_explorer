import 'package:upnped/upnped.dart';
import 'package:flutter/material.dart';

class DeviceImage extends StatelessWidget {
  final List<DeviceIcon> icons;
  final Uri? deviceIp;

  const DeviceImage({
    Key? key,
    required this.icons,
    this.deviceIp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 40,
        maxWidth: 40,
      ),
      child: icons.isEmpty || deviceIp == null
          ? const Icon(Icons.device_unknown)
          : Image.network(
              Uri(
                scheme: deviceIp!.scheme,
                host: deviceIp!.host,
                port: deviceIp!.port,
                path: icons.first.url.toString(),
              ).toString(),
            ),
    );
  }
}
