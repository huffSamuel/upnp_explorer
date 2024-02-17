import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upnp_explorer/application/network_logs/composite_specification.dart';

import '../../simple_upnp/src/upnp.dart';

class ThisDeviceOnlySpecification extends CompositeSpecification {
  ThisDeviceOnlySpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event is HttpRequestEvent || event.address == '127.0.0.1';
  }
}

class ReceivedSpecification extends CompositeSpecification {
  ReceivedSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.direction == Direction.inn;
  }
}

class SentSpecification extends CompositeSpecification {
  SentSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.direction == Direction.out;
  }
}

class HTTPSpecification extends CompositeSpecification {
  HTTPSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.protocol == 'http';
  }
}

class SSDPSpecification extends CompositeSpecification {
  SSDPSpecification({super.enabled});

  @override
  bool satisfiedBy(UPnPEvent event) {
    return event.protocol == 'ssdp';
  }
}

class Filters {
  final _default = ImmediateSpecification((event) => true, enabled: true);

  final received = ReceivedSpecification(enabled: false);
  final sent = SentSpecification(enabled: false);

  final http = HTTPSpecification(enabled: false);
  final ssdp = SSDPSpecification(enabled: false);

  final type = Map<String, CompositeSpecification>();
  final from = Map<String, CompositeSpecification>();
  final to = Map<String, CompositeSpecification>();

  late final _filter = BehaviorSubject<CompositeSpecification>.seeded(
    _default,
  );

  Stream<CompositeSpecification> get filter => _filter.stream;

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

  void update(CompositeSpecification spec, bool enabled) {
    spec.enabled = enabled;

    final ed = [received, sent].where((e) => e.enabled).toList();
    final ep = [http, ssdp].where((e) => e.enabled).toList();
    final ef = from.values.where((e) => e.enabled).toList();
    final et = to.values.where((e) => e.enabled).toList();
    final etype = type.values.where((e) => e.enabled).toList();

    if ([ed, ep, ef, et, etype].isEmpty) {
      _filter.add(_default);
      return;
    }

    _filter.add(CompositeSpecification.all([
      CompositeSpecification.any(ed),
      CompositeSpecification.any(ep),
      CompositeSpecification.any(ef),
      CompositeSpecification.any(et),
      CompositeSpecification.any(etype),
    ]));
  }
}

@singleton
class NetworkEventService {
  final filters = Filters();

  final _events = BehaviorSubject.seeded(<UPnPEvent>[]);

  final fromFilters = <CompositeSpecification>[];
  final toFilters = <CompositeSpecification>[];

  Stream<List<UPnPEvent>> get events => CombineLatestStream(
        <Stream<Object>>[_events, filters.filter],
        (values) => _filter(
          values[0] as Iterable<UPnPEvent>,
          values[1] as CompositeSpecification,
        ),
      );

  List<UPnPEvent> _filter(
    Iterable<UPnPEvent> events,
    CompositeSpecification spec,
  ) {
    final e = events.where((x) {
      final sat = spec.isSatisfiedBy(x);
      return sat;
    }).toList();

    return e;
  }

  NetworkEventService() {
    SimpleUPNP.instance().events.listen(_onEvent);
  }

  String _address(UPnPEvent event) {
    final authority = Uri.parse(event.address!).authority;

    return authority.isEmpty ? event.address! : authority;
  }

  void _onEvent(UPnPEvent event) {
    _events.add([
      ..._events.value,
      event,
    ]);

    final address = _address(event);

    if (event.direction == Direction.out) {
      filters.from.putIfAbsent(
        address,
        () => ImmediateSpecification((e) => _address(e) == address),
      );
    } else {
      filters.to.putIfAbsent(
        address,
        () => ImmediateSpecification((e) => _address(e) == address),
      );
    }

    filters.type.putIfAbsent(
      event.discriminator,
      () =>
          ImmediateSpecification((e) => e.discriminator == event.discriminator),
    );
  }

  void filter(CompositeSpecification spec, bool enabled) {
    filters.update(spec, enabled);
  }

  void clear() {
    _events.add([]);
    filters.clear();
  }
}
