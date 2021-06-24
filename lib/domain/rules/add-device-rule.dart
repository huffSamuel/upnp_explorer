import 'package:upnp_explorer/domain/device.dart';

class AddDeviceRule {
  execute(Device newDevice, Iterable<Device> devices) {
    return !devices.contains(newDevice);
  }
}
