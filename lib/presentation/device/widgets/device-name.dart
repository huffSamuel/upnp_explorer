import 'package:flutter/material.dart';
import 'package:upnp_explorer/domain/device.dart';

class DeviceName extends StatelessWidget {
  final Device device;

  final TextOverflow overflow;
  final TextStyle style;

  const DeviceName({
    Key key,
    @required this.device,
    this.overflow = TextOverflow.ellipsis,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ??
        Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 16,
            );

    return Text(
      device.properties.friendlyName ?? device.response.parsed['usn'],
      style: effectiveStyle,
      overflow: overflow,
    );
  }
}
