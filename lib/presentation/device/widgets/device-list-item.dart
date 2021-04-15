import 'package:flutter/material.dart';

import '../../../domain/device.dart';
import 'device-document-link.dart';
import 'device-image.dart';
import 'device-name.dart';

class DeviceListItem extends StatefulWidget {
  final Device device;
  final void Function(Device) onTap;

  const DeviceListItem({Key key, this.device, this.onTap}) : super(key: key);

  @override
  _DeviceListItemState createState() => _DeviceListItemState();
}

class _DeviceListItemState extends State<DeviceListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

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
      child: GestureDetector(
        onTap: () => widget.onTap(widget.device),
        child: Card(
          margin: const EdgeInsets.all(4.0),
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeviceImage(properties: widget.device.properties),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeviceName(device: widget.device),
                        DeviceDocumentLink(
                          location: widget.device.response.parsed['location'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
