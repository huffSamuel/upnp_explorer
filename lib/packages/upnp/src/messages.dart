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

  NetworkMessage({
    required this.direction,
    required this.protocol,
    required this.messageType,
  }) : time = DateTime.now();
}

class SearchRequest extends NetworkMessage {
  final String content;

  SearchRequest(this.content)
      : super(
          direction: MessageDirection.outgoing,
          protocol: MessageProtocol.ssdp,
          messageType: 'M-SEARCH',
        );

  toString() {
    return this.content;
  }
}

class NotifyResponse extends NetworkMessage {
  final String content;
  final String uri;

  NotifyResponse(this.uri, this.content)
      : super(
          direction: MessageDirection.incoming,
          protocol: MessageProtocol.ssdp,
          messageType: 'NOTIFY',
        );

  toString() {
    return this.content;
  }
}

class HttpMessage extends NetworkMessage {
  final http.Response response;
  http.BaseRequest get request => response.request!;

  HttpMessage(
    this.response,
  ) : super(
            direction: MessageDirection.outgoing,
            protocol: MessageProtocol.http,
            messageType: 'HTTP ${response.request!.method}');

  toString() {
    var sb = StringBuffer('HTTP/1.1 ${this.response.statusCode}\n');
    this.response.headers.forEach((k, v) => sb.writeln('$k: $v'));
    sb.writeln(this.response.body);
    return sb.toString();
  }
}
