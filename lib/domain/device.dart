import 'package:xml/xml.dart';

import '../data/ssdp_response_message.dart';
import 'device_document.dart';
import 'device_properties.dart';

class Device {
  final String ipAddress;
  final SSDPResponseMessage response;
  final List<DeviceDocument> documents = [];
  String locationData;
  DeviceProperties properties;
  XmlDocument xml;

  Device(this.response) : this.ipAddress = response.ipAddress;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device) && other.response == this.response;

  @override
  int get hashCode => this.response.hashCode;
}
