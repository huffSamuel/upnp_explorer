import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upnped/upnped.dart';

import 'filter_group.dart';
import 'property_filter.dart';

typedef FilterValueMap = Map<FilterGroup, Set<dynamic>>;
typedef FilterMap = Map<FilterGroup, PropertyFilter>;

@singleton
class FilterService {
  final filterValuesMap = BehaviorSubject<FilterValueMap>.seeded({});
  final filtersMap = BehaviorSubject<FilterMap>.seeded({});

  FilterService() {
    UPnPObserver.networkEvents.listen(_onEvent);
  }

  void _onEvent(NetworkEvent event) {
    final filterValues = filterValuesMap.value;
    final filters = filtersMap.value;

    if (event.direction == NetworkEventDirection.incoming) {
      final authority = Uri.parse(event.from!).authority;
      final from = authority.isEmpty ? event.from : authority;
      filterValues.putIfAbsent(FilterGroup.from, () => Set()).add(from);
      filters.putIfAbsent(
          FilterGroup.from, () => PropertyFilter(accessor: (e) => e.from));
    } else {
      String authority;

      if (event.to == null) {
        authority = 'localhost';
      } else {
        authority = Uri.parse(event.to!).authority;
      }

      final to = authority.isEmpty ? event.to : authority;
      filterValues.putIfAbsent(FilterGroup.to, () => Set()).add(to);
      filters.putIfAbsent(
        FilterGroup.to,
        () => PropertyFilter(accessor: (e) => e.to),
      );
    }

    filterValues.putIfAbsent(FilterGroup.type, () => Set()).add(event.type);
    filterValues
        .putIfAbsent(FilterGroup.direction, () => Set())
        .add(event.direction);
    filterValues
        .putIfAbsent(FilterGroup.protocol, () => Set())
        .add(event.protocol);

    filters.putIfAbsent(
      FilterGroup.type,
      () => PropertyFilter(accessor: (e) => e.type),
    );
    filters.putIfAbsent(
      FilterGroup.direction,
      () => PropertyFilter(accessor: (e) => e.direction),
    );
    filters.putIfAbsent(
      FilterGroup.protocol,
      () => PropertyFilter(accessor: (e) => e.protocol),
    );

    filterValuesMap.add(filterValues);
    filtersMap.add(filters);
  }

  void addFilter<T>(FilterGroup group, T value) {
    final filters = filtersMap.value;
    filters[group] = filters[group]!.addValue(value);
    filtersMap.add(filters);
  }

  void removeFilter<T>(FilterGroup group, T value) {
    final filters = filtersMap.value;
    filters[group] = filters[group]!.removeValue(value);
    filtersMap.add(filters);
  }

  void clearFilters() {
    final filters = filtersMap.value;

    for (final key in filters.keys) {
      filters[key] = filters[key]!.clear();
    }

    filtersMap.add(filters);
  }

  void reset() {
    filterValuesMap.add({});
    clearFilters();
  }
}
