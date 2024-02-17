part of simple_upnp;

enum Direction {
  inn,
  out,
}

abstract class UPnPEvent {
  final String discriminator;
  final Direction direction;
  final String protocol;
  final DateTime time;
  final String? address;

  UPnPEvent(
    this.discriminator,
    this.direction,
    this.protocol,
    this.time, {
    this.address,
  });

  String get content;
}

class NotifyEvent extends UPnPEvent {
  final String content;

  NotifyEvent(
    String from,
    this.content,
  ) : super(
          'NOTIFY',
          Direction.inn,
          'ssdp',
          DateTime.now(),
          address: from,
        );
}

class SearchEvent extends UPnPEvent {
  final String content;

  SearchEvent(
    this.content, [
    String? from,
    Direction direction = Direction.out,
  ]) : super(
          'M-SEARCH',
          direction,
          'ssdp',
          DateTime.now(),
          address: from,
        );

  factory SearchEvent.send(
    String content,
  ) {
    return SearchEvent(
      content,
      '127.0.0.1',
    );
  }

  factory SearchEvent.receive(
    String content,
    InternetAddress address,
  ) {
    return SearchEvent(
      content,
      address.host,
      Direction.inn,
    );
  }

  SearchEvent copyWith(
    InternetAddress from,
    int port,
  ) {
    return SearchEvent(
      this.content,
      '$from:$port',
    );
  }
}

class HttpRequestEvent extends UPnPEvent {
  final http.Response response;
  http.Request get request => response.request! as http.Request;

  String get requestBody =>
      XmlDocument.parse(request.body.trim()).toXmlString(pretty: true);
  String get responseBody =>
      XmlDocument.parse(response.body.trim()).toXmlString(pretty: true);

  @override
  String get content {
    var sb = StringBuffer('HTTP/1.1 ${this.response.statusCode}\n');
    this.response.headers.forEach((k, v) => sb.writeln('$k: $v'));
    sb.writeln(this.response.body);
    return sb.toString();
  }

  HttpRequestEvent(this.response)
      : super(
          'HTTP ${response.request!.method}',
          Direction.out,
          'http',
          DateTime.now(),
          address: response.request!.url.toString(),
        );
}
