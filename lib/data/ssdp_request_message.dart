import 'dart:convert';

class SSDPRequestMessage {
  final String searchTarget;
  final int maxResponseTime;

  SSDPRequestMessage(
      {this.searchTarget = 'upnp:rootdevice', this.maxResponseTime = 5});

  List<int> get encode => utf8.encode(this.toString());

  @override
  String toString() {
    return '''
M-SEARCH * HTTP/1.1
HOST: 239.255.255.250:1900
MAN: "ssdp:discover"
MX: $maxResponseTime
ST: $searchTarget
USER-AGENT: unix/5.1 UPnP/1.1 crash/1.0

''';
  }
}
