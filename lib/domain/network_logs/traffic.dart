import 'package:http/http.dart';

import 'direction.dart';
import 'protocol.dart';

class Traffic {
  final String message;
  final String origin;
  final Direction direction;
  final Protocol protocol;
  final DateTime dateTime;

  Traffic({
    required this.message,
    required this.protocol,
    required this.direction,
    required this.origin,
  }) : dateTime = DateTime.now();
}

const thisDevice = '0.0.0.0';

String requestToString(Request request) {
  final headers = request.headers.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));

  return '''
HTTP/1.1
${headers.map((x) => '${x.key}: ${x.value}').join('\n')}\n
${request.body}
''';
}

String responseToString(Response response) {
  final headers = response.headers.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));

  return '''
HTTP/1.1 ${response.statusCode}
${headers.map((x) => '${x.key}: ${x.value}').join('\n')}\n
${response.body}
''';
}
