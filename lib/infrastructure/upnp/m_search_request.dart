import 'dart:convert';

import 'search_target.dart';

class MSearchRequest {
  final SearchTarget searchTarget;
  final int maxResponseTime;

  MSearchRequest({
    this.searchTarget = const SearchTarget.rootDevice(),
    this.maxResponseTime = 5,
  });

  List<int> get encode => utf8.encode(toString());

  @override
  String toString() {
    return '''M-SEARCH * HTTP/1.1
HOST: 239.255.255.250:1900
MAN: "ssdp:discover"
MX: $maxResponseTime
ST: $searchTarget
USER-AGENT: Android/31 UPnP/1.1 upnpexplorer/1.0

''';
  }
}
