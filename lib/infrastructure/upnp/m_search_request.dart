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
    final builder = StringBuffer();

    builder
      ..write('M-SEARCH * HTTP/1.1\r\n')
      ..write('HOST: 239.255.255.250:1900\r\n')
      ..write('MAN: "ssdp:discover"\r\n')
      ..write('MX: $maxResponseTime\r\n')
      ..write('ST: $searchTarget\r\n')
      ..write('USER-AGENT: $userAgent\r\n')
      ..write('\r\n');
      
    return builder.toString();
  }
}
