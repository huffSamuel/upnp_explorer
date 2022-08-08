import 'package:injectable/injectable.dart';

import '../../domain/device/device_repository_type.dart';
import '../../infrastructure/upnp/device.dart';

@named
@Singleton(as: DeviceRepositoryType)
class DeviceRepository extends DeviceRepositoryType {
  Map<String, Device> devices = {};

  @override
  Device? get(String id) {
    if (devices.containsKey(id)) {
      return devices[id];
    }

    return null;
  }

  @override
  void insert(Device device) {
    devices[device.udn] = device;
  }
}
