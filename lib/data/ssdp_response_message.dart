import 'dart:convert';
import 'dart:io';

class SSDPResponseMessage {
  final String raw;
  final Map<String, String> parsed;

  String get location => parsed['location'];
  String get ipAddress => Uri.parse(location).host;

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
  String toString() {
    return parsed.values.join('\r\n');
  }
}
