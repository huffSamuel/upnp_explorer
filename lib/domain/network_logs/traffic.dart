enum TrafficDirection { incoming, outgoing }

enum TrafficProtocol {
  ssdp,
  upnp,
  soap,
}

class Traffic<T> {
  final T message;
  final TrafficDirection direction;
  final TrafficProtocol protocol;
  final DateTime dateTime;

  Traffic(
    this.message,
    this.protocol,
    this.direction,
  ) : dateTime = DateTime.now();
}