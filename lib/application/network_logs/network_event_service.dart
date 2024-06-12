import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upnped/upnped.dart';

import 'filters_service.dart';

@singleton
class NetworkEventService {
  final FilterService filterService;
  final _allEvents = BehaviorSubject.seeded(<NetworkEvent>[]);

  Stream<List<NetworkEvent>> get events => CombineLatestStream(
      [_allEvents, filterService.filtersMap],
      (values) => _filterEvents(
            values[0] as Iterable<NetworkEvent>,
            values[1] as FilterMap,
          ));

  List<NetworkEvent> _filterEvents(
    Iterable<NetworkEvent> events,
    FilterMap filters,
  ) {
    return events.where((event) {
      for (final v in filters.values) {
        if (!v.isSatisfied(event)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  NetworkEventService(this.filterService) {
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
    filterService.reset();
  }
}
