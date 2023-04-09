part of upnp;

class Client {
  final String _raw;
  final Map<String, String> _parsed;

  /// After this duration, control points should assume the device is no longer available.
  String? get cacheControl => _parsed['cache-control'];

  /// The RFC1123-date date when this response was generated.
  DateTime? get date =>
      _parsed['date'] == null ? null : HttpDate.parse(_parsed['date']!);

  /// Required for backwards compatibility with UPnP 1.0.
  String? get ext => _parsed['ext'];

  /// The URL to the UPnP description of the root device.
  Uri? get location =>
      _parsed['location'] == null ? null : Uri.parse(_parsed['location']!);

  ///
  String? get opt => _parsed['opt'];

  /// Specified by the UPnP vendor, this specifies product tokens for the device.
  String? get server => _parsed['server'];

  /// The search target. This field changes depending on the search request.
  String? get searchTarget => _parsed['st'];

  /// A unique service name for this device.
  String? get usn => _parsed['usn'];

  Client._(this._raw, this._parsed);

  factory Client.fromPacket(Datagram packet) {
    final data = utf8.decode(packet.data);
    Map<String, String> parsed = {};

    for (var segment in data.split('\r\n')) {
      final colon = segment.indexOf(':');

      if (colon != -1) {
        final key = segment.substring(0, colon).trim().toLowerCase();
        final value = segment.substring(colon + 1).trim();
        parsed.putIfAbsent(key, () => value);
      }
    }

    return Client._(data, parsed);
  }

  @override
  String toString() {
    return _raw;
  }
}
