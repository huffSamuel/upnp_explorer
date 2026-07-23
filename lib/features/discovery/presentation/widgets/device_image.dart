import 'package:flutter/material.dart';
import 'devices_card.dart';
import 'package:upnped/upnped.dart';

class DeviceImage2 extends StatelessWidget {
  final DeviceDescription device;
  final Uri? deviceIp;
  final BoxDecoration? decoration;

  const DeviceImage2({
    super.key,
    required this.device,
    required this.deviceIp,
    this.decoration,
  });

  Uri get _uri => device.iconList.first.url.hasScheme
      ? device.iconList.first.url
      : Uri(
          scheme: deviceIp!.scheme,
          host: deviceIp!.host,
          port: deviceIp!.port,
          path: device.iconList.first.url.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'device-icon',
      child: Container(
          padding: device.iconList.isEmpty ? EdgeInsets.all(24) : EdgeInsets.zero,
          decoration: decoration,
          child: device.iconList.isNotEmpty
              ? SizedBox(
                  height: 74,
                  width: 74,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Image.network(_uri.toString())),
                )
              : Icon(mapDeviceIcon(device.deviceType.uri))),
    );
  }
}

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
    final image = icons.isEmpty || deviceIp == null
        ? Container(
            child: const Icon(Icons.device_unknown),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          )
        : Image.network(_uri.toString());

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 64,
        width: 64,
        child: image,
      ),
    );
  }
}
