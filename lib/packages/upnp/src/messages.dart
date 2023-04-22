part of upnp;

enum MessageProtocol {
  ssdp,
  http,
  soap,
}

enum MessageDirection {
  incoming,
  outgoing,
}

abstract class NetworkMessage {
  final MessageDirection direction;
  final MessageProtocol protocol;
  final DateTime time;
  final String messageType;
  final String? from;
  final String? to;

  NetworkMessage({
    required this.direction,
    required this.protocol,
    required this.messageType,
    this.from,
    this.to,
  }) : time = DateTime.now();
}

class SearchRequest extends NetworkMessage {
  final String content;

  SearchRequest(this.content)
      : super(
          direction: MessageDirection.outgoing,
          protocol: MessageProtocol.ssdp,
          messageType: 'M-SEARCH',
          from: '0.0.0.0',
        );

  toString() {
    return this.content;
  }
}

class NotifyResponse extends NetworkMessage {
  final String content;
  final Uri uri;

  NotifyResponse(this.uri, this.content)
      : super(
          direction: MessageDirection.incoming,
          protocol: MessageProtocol.ssdp,
          messageType: 'NOTIFY',
          from: uri.host,
        );

  toString() {
    return this.content;
  }
}

class HttpMessage extends NetworkMessage {
  final http.Response response;
  http.Request get request => response.request! as http.Request;

  HttpMessage(
    this.response,
  ) : super(
          direction: MessageDirection.outgoing,
          protocol: MessageProtocol.http,
          messageType: 'HTTP ${response.request!.method}',
          from: '0.0.0.0',
          to: response.request!.url.host,
        );

  toString() {
    var sb = StringBuffer('HTTP/1.1 ${this.response.statusCode}\n');
    this.response.headers.forEach((k, v) => sb.writeln('$k: $v'));
    sb.writeln(this.response.body);
    return sb.toString();
  }
}
