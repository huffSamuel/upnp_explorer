import 'dart:convert';

import 'models/search_target.dart';

class MSearchRequest {
  final SearchTarget searchTarget;
  final int maxResponseTime;
  final String userAgent;

  MSearchRequest({
    required this.userAgent,
    this.searchTarget = const SearchTarget.rootDevice(),
    this.maxResponseTime = 5,
  });

  List<int> encode() => utf8.encode(toString());

  @override
  String toString() {
    return '''M-SEARCH * HTTP/1.1\r
HOST: 239.255.255.250:1900\r
MAN: "ssdp:discover"\r
MX: $maxResponseTime\r
ST: $searchTarget\r
USER-AGENT: $userAgent\r
\r
''';
  }
}
