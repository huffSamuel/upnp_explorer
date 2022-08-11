import 'package:upnp_explorer/infrastructure/upnp/device.dart';

import 'device.dart';

abstract class DeviceRepositoryType {
  Device? get(String id);
  void insert(Device device);
}