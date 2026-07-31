import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upnped/upnped.dart';

typedef FilterFn = bool Function(NetworkEvent event);

class NetworkEventFilter {
  final String ipAddress;
  final List<String> eventTypes;

  NetworkEventFilter(
      {this.ipAddress = '', this.eventTypes = NetworkEventType.all});
}

@singleton
@Environment(Environment.prod)
class NetworkEventService {
  final _allEvents = BehaviorSubject.seeded(<NetworkEvent>[]);
  final _filter = BehaviorSubject.seeded(NetworkEventFilter());

  Stream<List<NetworkEvent>> get events => CombineLatestStream(
      [_allEvents, _filter],
      (values) => _filterEvents(
            values[0] as Iterable<NetworkEvent>,
            values[1] as NetworkEventFilter,
          ));

  NetworkEventFilter get filter => _filter.value;

  void setFilter(NetworkEventFilter value) {
    _filter.add(value);
  }

  List<NetworkEvent> _filterEvents(
    Iterable<NetworkEvent> events,
    NetworkEventFilter filter,
  ) {
    Iterable<NetworkEvent> effective = [...events];

    if (filter.ipAddress.isNotEmpty == true) {
      effective = effective.where((e) => e.from == filter.ipAddress);
    }

    if (filter.eventTypes.isNotEmpty) {
      effective = effective.where((e) => filter.eventTypes.contains(e.type));
    }

    // Handle filtering the types here

    return effective.toList();
  }

  NetworkEventService() {
    UPnPObserver.networkEvents.listen(_onEvent);
  }

  void _onEvent(NetworkEvent event) {
    _allEvents.add([
      ..._allEvents.value,
      event,
    ]);
  }

  void clear() {
    _allEvents.add([]);
  }
}
