import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:upnp_explorer/generated/l10n.dart';

import '../../../constants.dart';
import '../../../domain/device.dart';
import '../../../infrastructure/services/ioc.dart';
import '../../../infrastructure/services/ssdp_discovery.dart';
import '../widgets/device-list-item.dart';
import '../widgets/refresh-button.dart';
import '../widgets/scanning-indicator.dart';
import '../widgets/settings-icon-button.dart';
import 'device-page.dart';

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList>
    with SingleTickerProviderStateMixin {
  final service = sl<SSDPService>();
  List<Device> devices = [];
  var _scanning = false;
  var _height = 0.0;

  void initState() {
    super.initState();
    service.stream.listen(_onDeviceDiscovered);
    _scan();
  }

  void _stopScan() {
    setState(() {
      _scanning = false;
      _height = 0;
    });
  }

  void _startScan() {
    setState(() {
      _scanning = true;
      _height = 7;
    });
  }

  void _scan() {
    service.findDevices().then((_) => _stopScan());

    _startScan();
  }

  void _onDeviceDiscovered(Device d) {
    if (!devices.contains(d)) {
      setState(() => devices.add(d));
    }
  }

  void _refresh() {
    setState(() {
      devices.clear();
      _scan();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_scanning) {
      body = ListView.builder(
        itemCount: devices.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ScanningIndicator(height: _height);
          } else {
            return _makeElement(index - 1);
          }
        },
      );
    } else {
      body = ListView.builder(
        itemCount: math.max(devices.length, 1),
        itemBuilder: (context, index) {
          if (index == 0 && devices.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).noDevicesFound),
              ),
            );
          }

          return _makeElement(index);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: SettingsIconButton(),
        title: Text(kAppName),
        actions: [
          RefreshIconButton(
            onPressed: _scanning ? null : () => _refresh(),
          ),
        ],
      ),
      body: Center(
        child: Scrollbar(child: body),
      ),
    );
  }

  Widget _makeElement(int index) {
    if (index >= devices.length) {
      return null;
    }

    return DeviceListItem(
      device: devices[index],
      onTap: (device) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) => PageView.builder(
            itemCount: devices.length,
            controller: PageController(initialPage: devices.indexOf(device)),
            itemBuilder: (context, index) => DevicePage(
              device: devices[index],
            ),
          ),
        ),
      ),
    );
  }
}
