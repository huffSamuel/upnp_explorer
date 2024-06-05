import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upnped/upnped.dart';

import '../../libraries/specification/specification.dart';

String eventAddress(NetworkEvent event) {
  final authority = Uri.parse(event.from!).authority;

  return authority.isEmpty ? event.from! : authority;
}

abstract class Filter extends CompositeSpecification<NetworkEvent> {
  bool enabled = false;

  Filter({this.enabled = false}) {}

  bool satisfiedBy(NetworkEvent event);

  bool isSatisfied(NetworkEvent event) {
    if (!enabled) {
      return false;
    }

    return satisfiedBy(event);
  }
}

class DiscriminatorSpecification extends Filter {
  final String expected;

  DiscriminatorSpecification(this.expected);

  @override
  bool satisfiedBy(NetworkEvent event) {
    return event.type == expected;
  }
}

class AddressSpecification extends Filter {
  final String expected;

  AddressSpecification(this.expected);

  @override
  bool satisfiedBy(NetworkEvent event) {
    return eventAddress(event) == expected;
  }
}

class ReceivedSpecification extends Filter {
  ReceivedSpecification({super.enabled});

  @override
  bool satisfiedBy(NetworkEvent event) {
    return event.direction == NetworkEventDirection.incoming;
  }
}

class SentSpecification extends Filter {
  SentSpecification({super.enabled});

  @override
  bool satisfiedBy(NetworkEvent event) {
    return event.direction == NetworkEventDirection.outgoing;
  }
}

class HTTPSpecification extends Filter {
  HTTPSpecification({super.enabled});

  @override
  bool satisfiedBy(NetworkEvent event) {
    return event.protocol == NetworkEventProtocol.http;
  }
}

class SSDPSpecification extends Filter {
  SSDPSpecification({super.enabled});

  @override
  bool satisfiedBy(NetworkEvent event) {
    return event.protocol == NetworkEventProtocol.ssdp;
  }
}

class ShowAllFilter extends Filter {
  ShowAllFilter({super.enabled = true});

  @override
  bool satisfiedBy(NetworkEvent event) {
    return true;
  }
}

class Filters {
  final _default = ShowAllFilter();

  final received = ReceivedSpecification(enabled: false);
  final sent = SentSpecification(enabled: false);

  final http = HTTPSpecification(enabled: false);
  final ssdp = SSDPSpecification(enabled: false);

  final type = Map<String, Filter>();
  final from = Map<String, Filter>();
  final to = Map<String, Filter>();

  late final _filter =
      BehaviorSubject<CompositeSpecification<NetworkEvent>>.seeded(
    _default,
  );

  Stream<CompositeSpecification<NetworkEvent>> get filter => _filter.stream;

  void clear() {
    from.clear();
    to.clear();
    type.clear();
  }

  void reset() {
    [
      received,
      sent,
      http,
      ssdp,
      ...type.values,
      ...from.values,
      ...to.values,
    ].forEach((x) => x.enabled = false);

    _default.enabled = true;
  }

  void update(Filter filter, bool enabled) {
    filter.enabled = enabled;

    final ed = [received, sent].where((e) => e.enabled).toList();
    final ep = [http, ssdp].where((e) => e.enabled).toList();
    final ef = from.values.where((e) => e.enabled).toList();
    final et = to.values.where((e) => e.enabled).toList();
    final etype = type.values.where((e) => e.enabled).toList();

    if ([ed, ep, ef, et, etype].isEmpty) {
      _filter.add(_default);
      return;
    }

    _filter.add(all([
      any(ed),
      any(ep),
      any(ef),
      any(et),
      any(etype),
    ]));
  }
}

@singleton
class NetworkEventService {
  final filters = Filters();

  final _events = BehaviorSubject.seeded(<NetworkEvent>[]);

  final fromFilters = <Filter>[];
  final toFilters = <Filter>[];

  Stream<List<NetworkEvent>> get events => CombineLatestStream(
        <Stream<Object>>[_events, filters.filter],
        (values) => _filter(
          values[0] as Iterable<NetworkEvent>,
          values[1] as CompositeSpecification<NetworkEvent>,
        ),
      );

  List<NetworkEvent> _filter(
    Iterable<NetworkEvent> events,
    CompositeSpecification<NetworkEvent> spec,
  ) {
    final e = events.where((x) {
      final sat = spec.isSatisfied(x);
      return sat;
    }).toList();

    return e;
  }

  NetworkEventService() {
    UPnPObserver.networkEvents.listen(_onEvent);
  }
  void _onEvent(NetworkEvent event) {
    _events.add([
      ..._events.value,
      event,
    ]);

    final address = eventAddress(event);
    Map<String, Filter> addressMap;

    if (event.direction == NetworkEventDirection.outgoing) {
      addressMap = filters.from;
    } else {
      addressMap = filters.to;
    }

    addressMap.putIfAbsent(address, () => AddressSpecification(address));

    filters.type.putIfAbsent(
      event.type,
      () => DiscriminatorSpecification(event.type),
    );
  }

  void filter(Filter filter, bool enabled) {
    filters.update(filter, enabled);
  }

  void clearFilters() {
    filters.reset();
  }

  void clear() {
    _events.add([]);
    filters.clear();
  }
}
