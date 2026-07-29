import 'package:injectable/injectable.dart';
import 'package:upnped/upnped.dart';

@singleton
class DeviceService {
  List<Device> _devices = [];

  List<Device> get devices => [..._devices];

  void add(Device device) {
    _devices.add(device);
  }

  void clear(){
    _devices.clear();
  }
}
