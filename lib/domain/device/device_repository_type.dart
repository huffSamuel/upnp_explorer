import '../../infrastructure/upnp/device.dart';

abstract class DeviceRepositoryType {
  Device? get(String id);
  void insert(Device device);
}