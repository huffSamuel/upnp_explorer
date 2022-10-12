import 'dart:convert';
import 'dart:io';

import 'models/server.dart';

class SSDPResponseMessage {
  final String raw;
  final Map<String, String> parsed;

  /// After this duration, control points should assume the device is no longer
  /// available.
  String get cacheControl => parsed['cache-control']!;

  /// The RFC1123-date date when this response was generated.
  DateTime get date => HttpDate.parse(parsed['date']!);

  /// Required for backwards compatibility with UPnP 1.0.
  String get ext => parsed['ext']!;

  /// The URL to the UPnP description of the root device.
  Uri get location => Uri.parse(parsed['location']!);

  /// 
  String? get opt => parsed['opt'];

  /// Specified by the UPnP vendor, this specifies product tokens for the device.
  UpnpServer get server => UpnpServer.parse(parsed['server']!);

  /// The search target. This field changes depending on the search request.
  String get searchTarget => parsed['st']!;

  /// A unique name for this device.
  String get uniqueServiceName => parsed['usn']!;

  String get origin => location.origin;

  SSDPResponseMessage(this.raw, this.parsed);

  factory SSDPResponseMessage.fromPacket(Datagram packet) {
    var data = utf8.decode(packet.data);
    Map<String, String> parsed = {};
    for (var segment in data.split('\r\n')) {
      final colon = segment.indexOf(':');
      if (colon != -1) {
        var key = segment.substring(0, colon).trim().toLowerCase();
        var value = segment.substring(colon + 1).trim();
        parsed.putIfAbsent(key, () => value);
      }
    }

    return SSDPResponseMessage(data, parsed);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SSDPResponseMessage) && other.location == this.location;

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() {
    return parsed.entries.map((x) => '${x.key}:${x.value}').join('\r\n');
  }
}
