import 'package:flutter/material.dart';
import 'package:ssdp/constants.dart';
import 'package:ssdp/presentation/settings/pages/settings-page.dart';

import '../../../domain/device.dart';
import '../../../infrastructure/services/ioc.dart';
import '../../../infrastructure/services/ssdp_discovery.dart';
import '../widgets/device-list-item.dart';
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

  @override
  Widget build(BuildContext context) {
    final indicator = AnimatedContainer(
      height: _height,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 150),
      child: LinearProgressIndicator(
        backgroundColor: Theme.of(context).canvasColor,
        valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (c) => SettingsPage()),
          ),
        ),
        title: Text(kAppName),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _scanning
                ? null
                : () => setState(() {
                      devices.clear();
                      _scan();
                    }),
          )
        ],
      ),
      body: Center(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: devices.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return indicator;
              }
              return _makeElement(index - 1);
            },
          ),
        ),
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
