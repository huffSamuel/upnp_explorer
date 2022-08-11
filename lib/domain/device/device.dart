import '../../infrastructure/upnp/ssdp_response_message.dart';
import '../../infrastructure/upnp/device.dart';

class UPnPDevice {
  final SSDPResponseMessage discoveryResponse;
  final DeviceDescription description;

  Uri get ipAddress => Uri.parse(discoveryResponse.ipAddress);

  UPnPDevice(this.discoveryResponse, this.description);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UPnPDevice) && other.discoveryResponse == this.discoveryResponse;

  @override
  int get hashCode => this.discoveryResponse.hashCode ^ 7 >> 13;
}
