import '../../infrastructure/upnp/models/device.dart';

abstract class DeviceRepositoryType {
  Device? get(String id);
  void insert(Device device);
}