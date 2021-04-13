import 'package:flutter/material.dart';

import '../../../domain/device.dart';

class DeviceImage extends StatelessWidget {
  final DeviceProperties properties;

  const DeviceImage({
    Key key,
    @required this.properties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: properties.imageUri() == null
          ? Icon(Icons.device_unknown)
          : Image.network(
              properties.imageUri().toString(),
            ),
    );
  }
}
