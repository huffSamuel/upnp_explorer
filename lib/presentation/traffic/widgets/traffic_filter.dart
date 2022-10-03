import 'package:http/http.dart';

import '../../../application/device/traffic_repository.dart';
import '../../../infrastructure/ssdp/device_discovery_service.dart';
import '../../../infrastructure/upnp/ssdp_response_message.dart';

class TrafficFilter {
  final bool Function(Traffic) callback;
  final String id;

  TrafficFilter._(this.id, this.callback);

  factory TrafficFilter.all() {
    return TrafficFilter._('all', (p) => true);
  }

  factory TrafficFilter.direction(TrafficDirection direction) {
    return TrafficFilter._(
      direction.toString(),
      (p) => p.direction == direction,
    );
  }

  factory TrafficFilter.protocol(TrafficProtocol protocol) {
    return TrafficFilter._(
      protocol.toString(),
      (p) => p.protocol == protocol,
    );
  }

  factory TrafficFilter.origin(String source) {
    return TrafficFilter._(
      'source.$source',
      (traffic) {
        String origin = '';

        if (traffic is Traffic<SearchRequest>) {
          origin = traffic.message.address;
        }

        if (traffic is Traffic<SSDPResponseMessage>) {
          origin = traffic.message.location.authority;
        }

        if (traffic is Traffic<Response>) {
          origin = traffic.message.request!.url.authority;
        }

        return origin == source;
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TrafficFilter) && other.id == this.id;

  bool permit(Traffic traffic) => callback(traffic);

  @override
  int get hashCode => id.hashCode;
}
