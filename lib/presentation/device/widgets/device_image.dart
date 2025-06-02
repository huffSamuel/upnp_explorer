import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import 'leading_icon_builder.dart';

class DeviceImage extends StatelessWidget {
  final List<DeviceIcon> icons;
  final Uri? deviceIp;

  const DeviceImage({
    Key? key,
    required this.icons,
    this.deviceIp,
  }) : super(key: key);

  Uri get _uri => icons.first.url.hasScheme
      ? icons.first.url
      : Uri(
          scheme: deviceIp!.scheme,
          host: deviceIp!.host,
          port: deviceIp!.port,
          path: icons.first.url.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return LeadingIconBuilder(
      builder: (context) => icons.isEmpty || deviceIp == null
          ? const Icon(Icons.device_unknown)
          : Image.network(
              _uri.toString(),
            ),
    );
  }
}
