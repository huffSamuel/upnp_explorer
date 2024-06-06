import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';
import '../../../application/network_logs/filter_group.dart';
import '../../../application/network_logs/filters_service.dart';
import '../../../application/network_logs/network_event_service.dart';
import 'package:upnped/upnped.dart';

import '../../../application/ioc.dart';
import '../widgets/filter_group_expansion_tile.dart';

class FiltersPage extends StatefulWidget {
  FiltersPage();

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  final FilterService _service = sl<FilterService>();
  final NetworkEventService _eventService = sl<NetworkEventService>();

  void _resetFilters() {
    _service.clearFilters();
  }

  void _updateFilter<T>(FilterGroup group, T value, bool? enabled) {
    if (enabled == true) {
      _service.addFilter(group, value);
    } else {
      _service.removeFilter(group, value);
    }
  }

  Widget _filterGroup<T>(
    FilterGroup group,
    String title,
    FilterMap filters,
    FilterValueMap valueMap, [
    Map<T, String>? titleMap,
  ]) =>
      FilterGroupExpansionTile(
        title: title,
        filter: filters[group]!,
        allowedValues: valueMap[group]!,
        onChanged: (k, e) => _updateFilter(group, k, e),
        titleResolver: titleMap,
      );

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          i18n.filters,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all_rounded),
            onPressed: _resetFilters,
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: _eventService.events,
                builder: (context, snapshot) => ListTile(
                  title: Text(i18n.countVisible(snapshot.data?.length ?? 0)),
                ),
              ),
              StreamBuilder(
                stream: CombineLatestStream(
                  [
                    _service.filtersMap,
                    _service.filterValuesMap,
                  ],
                  (x) => x,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container();
                  }

                  if (!snapshot.hasData) {
                    return Container();
                  }

                  final filters = snapshot.data![0] as FilterMap;
                  final allowedFilters = snapshot.data![1] as FilterValueMap;

                  return Column(
                    children: [
                      _filterGroup(
                        FilterGroup.direction,
                        i18n.directionDescription,
                        filters,
                        allowedFilters,
                        Map.fromEntries(
                          NetworkEventDirection.values.map(
                            (x) => MapEntry(x, i18n.direction(x.name)),
                          ),
                        ),
                      ),
                      _filterGroup(
                        FilterGroup.protocol,
                        i18n.protocolDescription,
                        filters,
                        allowedFilters,
                        {
                          NetworkEventProtocol.http: 'HTTP',
                          NetworkEventProtocol.ssdp: 'SSDP',
                        },
                      ),
                      _filterGroup(
                          FilterGroup.type, i18n.type, filters, allowedFilters),
                      _filterGroup(
                          FilterGroup.from, i18n.from, filters, allowedFilters),
                      _filterGroup(
                          FilterGroup.to, i18n.to, filters, allowedFilters),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
