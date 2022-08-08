import 'package:flutter/material.dart';

import '../../../domain/device/device.dart';
import 'device-image.dart';

class DeviceListItem extends StatefulWidget {
  final UPnPDevice device;
  final void Function(UPnPDevice) onTap;

  const DeviceListItem({
    Key? key,
    required this.device,
    required this.onTap,
  }) : super(key: key);

  @override
  _DeviceListItemState createState() => _DeviceListItemState();
}

class _DeviceListItemState extends State<DeviceListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return FadeTransition(
      opacity: _animation,
      child: ListTile(
        leading: DeviceImage(
          icons: widget.device.description.device.iconList.icons,
          deviceIp: widget.device.ipAddress,
        ),
        title: Text(
          widget.device.description.device.friendlyName,
        ),
        subtitle: Text(widget.device.ipAddress.toString()),
        trailing: Icon(Icons.chevron_right),
        onTap: () => widget.onTap(widget.device),
      ),
    );
  }
}
