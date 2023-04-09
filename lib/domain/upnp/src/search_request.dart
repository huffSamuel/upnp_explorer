part of upnp;

class MSearchRequest {
  /// Search target
  final String st;

  /// Maximum response time
  final int mx;

  /// User agent
  final String operatingSystem;

  MSearchRequest({
    required this.operatingSystem,
    String? st,
    this.mx = 1,
  }) : st = st ?? SearchTarget.rootDevice();

  List<int> encode() => utf8.encode(toString());

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer
      ..write('M-SEARCH * HTTP/1.1\r\n')
      ..write('HOST: 239.255.255.250:1900\r\n')
      ..write('MAN: "ssdp:discover"\r\n')
      ..write('MX: $mx\r\n')
      ..write('ST: $st\r\n')
      ..write('USER-AGENT: $operatingSystem UPnP/1.1 upnp_cnc/1.0 \r\n')
      ..write('\r\n');

    return buffer.toString();
  }
}
