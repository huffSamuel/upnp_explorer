import 'package:upnp_explorer/domain/upnp/upnp.dart';

class TrafficFilter {
  final bool Function(NetworkMessage) callback;
  final String id;

  TrafficFilter._(this.id, this.callback);

  factory TrafficFilter.all() {
    return TrafficFilter._('all', (p) => true);
  }

  factory TrafficFilter.direction(MessageDirection direction) {
    return TrafficFilter._(
      direction.toString(),
      (p) => p.direction == direction,
    );
  }

  factory TrafficFilter.protocol(MessageProtocol protocol) {
    return TrafficFilter._(
      protocol.toString(),
      (p) => p.protocol == protocol,
    );
  }

  factory TrafficFilter.origin(String source) {
    return TrafficFilter._(
      'source.$source',
      (traffic) {
        return true;
// return traffic == source;
      } 
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TrafficFilter) && other.id == this.id;

  bool permit(NetworkMessage traffic) => callback(traffic);

  @override
  int get hashCode => id.hashCode;
}
