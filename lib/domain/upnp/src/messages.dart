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

  NetworkMessage({
    required this.direction,
    required this.protocol,
  }) : time = DateTime.now();
}

class SearchRequest extends NetworkMessage {
  final String content;

  SearchRequest(this.content)
      : super(
          direction: MessageDirection.outgoing,
          protocol: MessageProtocol.ssdp,
        );
}

class NotifyResponse extends NetworkMessage {
  final String content;
  final String uri;

  NotifyResponse(this.uri, this.content)
      : super(
          direction: MessageDirection.incoming,
          protocol: MessageProtocol.ssdp,
        );
}

class InvokeActionRequest extends NetworkMessage {
  final String requestBody;
  final String responseBody;
  final String uri;
  final int status;

  InvokeActionRequest(
    this.uri,
    this.requestBody,
    this.responseBody,
    this.status,
  ) : super(
          direction: MessageDirection.outgoing,
          protocol: MessageProtocol.soap,
        );
}

class HttpMessage extends NetworkMessage {
  final http.Response response;
  http.BaseRequest get request => response.request!;

  HttpMessage(
    this.response,
  ) : super(
          direction: MessageDirection.outgoing,
          protocol: MessageProtocol.http,
        );
}
