import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../libraries/simple_upnp/src/upnp.dart';
import '../../libraries/specification/specification.dart';

String eventAddress(UPnPEvent event) {
  final authority = Uri.parse(event.address!).authority;

  return authority.isEmpty ? event.address! : authority;
}

abstract class Filter extends CompositeSpecification<UPnPEvent> {
  bool enabled = false;

  Filter({this.enabled = false}) {}

  bool satisfiedBy(UPnPEvent event);

  bool isSatisfied(UPnPEvent event) {
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
  bool satisfiedBy(UPnPEvent event) {
    return event.discriminator == expected;
  }
}

class AddressSpecification extends Filter {
  final String expected;

  AddressSpecification(this.expected);

  @override
  bool satisfiedBy(UPnPEvent event) {
    return eventAddress(event) == expected;
  }
}

class ReceivedSpecification extends Filter {
  ReceivedSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.direction == Direction.inn;
  }
}

class SentSpecification extends Filter {
  SentSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.direction == Direction.out;
  }
}

class HTTPSpecification extends Filter {
  HTTPSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.protocol == 'http';
  }
}

class SSDPSpecification extends Filter {
  SSDPSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.protocol == 'ssdp';
  }
}

class ShowAllFilter extends Filter {
  ShowAllFilter({super.enabled = true});

  @override
  bool satisfiedBy(UPnPEvent event) {
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
      BehaviorSubject<CompositeSpecification<UPnPEvent>>.seeded(
    _default,
  );

  Stream<CompositeSpecification<UPnPEvent>> get filter => _filter.stream;

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

  final _events = BehaviorSubject.seeded(<UPnPEvent>[]);

  final fromFilters = <Filter>[];
  final toFilters = <Filter>[];

  Stream<List<UPnPEvent>> get events => CombineLatestStream(
        <Stream<Object>>[_events, filters.filter],
        (values) => _filter(
          values[0] as Iterable<UPnPEvent>,
          values[1] as CompositeSpecification<UPnPEvent>,
        ),
      );

  List<UPnPEvent> _filter(
    Iterable<UPnPEvent> events,
    CompositeSpecification<UPnPEvent> spec,
  ) {
    final e = events.where((x) {
      final sat = spec.isSatisfied(x);
      return sat;
    }).toList();

    return e;
  }

  NetworkEventService() {
    SimpleUPNP.instance().events.listen(_onEvent);
  }
  void _onEvent(UPnPEvent event) {
    _events.add([
      ..._events.value,
      event,
    ]);

    final address = eventAddress(event);
    Map<String, Filter> addressMap;

    if (event.direction == Direction.out) {
      addressMap = filters.from;
    } else {
      addressMap = filters.to;
    }

    addressMap.putIfAbsent(address, () => AddressSpecification(address));

    filters.type.putIfAbsent(
      event.discriminator,
      () => DiscriminatorSpecification(event.discriminator),
    );
  }

  void filter(Filter filter, bool enabled) {
    filters.update(filter, enabled);
  }

  void clear() {
    _events.add([]);
    filters.clear();
  }
}
