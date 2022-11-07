import '../../../domain/network_logs/direction.dart';
import '../../../domain/network_logs/protocol.dart';
import '../../../domain/network_logs/traffic.dart';

class TrafficFilter {
  final bool Function(Traffic) callback;
  final String id;

  TrafficFilter._(this.id, this.callback);

  factory TrafficFilter.all() {
    return TrafficFilter._('all', (p) => true);
  }

  factory TrafficFilter.direction(Direction direction) {
    return TrafficFilter._(
      direction.toString(),
      (p) => p.direction == direction,
    );
  }

  factory TrafficFilter.protocol(Protocol protocol) {
    return TrafficFilter._(
      protocol.toString(),
      (p) => p.protocol == protocol,
    );
  }

  factory TrafficFilter.origin(String source) {
    return TrafficFilter._(
      'source.$source',
      (traffic) => traffic.origin == source,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TrafficFilter) && other.id == this.id;

  bool permit(Traffic traffic) => callback(traffic);

  @override
  int get hashCode => id.hashCode;
}
