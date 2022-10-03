import 'dart:async';

import 'package:injectable/injectable.dart';
enum TrafficDirection{
  incoming,
  outgoing
}

enum TrafficProtocol {
  ssdp,
  upnp,
}

class Traffic<T> {
  final T message;
  final TrafficDirection direction;
  final TrafficProtocol protocol;

  Traffic(this.message, this.protocol, this.direction);
}

final _controller = StreamController<Traffic>.broadcast();

Stream<Traffic> get trafficStream => _controller.stream;

@Singleton()
class TrafficRepository {
  List<Traffic> _traffic = [];

  List<Traffic> getAll() {
    return _traffic;
  }

  void clear() {
    _traffic.clear();
  }

  void add(Traffic item) {
    _traffic.add(item);
  }
}
