import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/ioc.dart';
import '../../../application/network_logs/filter_state.dart';
import '../../../domain/network_logs/network_logs_repository_type.dart';
import '../../../packages/upnp/upnp.dart';

class FiltersPage extends StatefulWidget {
  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  final _from = <Filter<NetworkMessage>>[];
  final _to = <Filter<NetworkMessage>>[];
  final _direction = <Filter<NetworkMessage>>[];
  final _protocol = <Filter<NetworkMessage>>[];

  final _repo = sl<NetworkLogsRepositoryType>();

  late StreamSubscription _messageSubscription;

  void _onMessage(NetworkMessage message) {
    if (!mounted) {
      return;
    }

    setState(() {
      final i18n = AppLocalizations.of(context)!;

      if (!_protocol.any((x) => x.id == 'Protocol: ${message.protocol.name}')) {
        _protocol.add(
          Filter(
            (x) => x.protocol == message.protocol,
            message.protocol.name.toUpperCase(),
            id: 'Protocol: ${message.protocol.name}',
          ),
        );
      }

      if (!_direction
          .any((x) => x.id == 'Direction: ${message.direction.name}')) {
        _direction.add(
          Filter(
            (x) => x.direction == message.direction,
            i18n.direction(message.direction.name),
            id: 'Direction: ${message.direction.name}',
          ),
        );
      }

      if (message.to != null && !_to.any((x) => x.id == 'To: ${message.to}')) {
        _to.add(
          Filter(
            (x) => x.to == message.to,
            message.to!,
            id: 'To: ${message.to}',
          ),
        );
      }

      if (message.from != null &&
          !_from.any((x) => x.id == 'From: ${message.from}')) {
        _from.add(
          Filter(
            (x) => x.from == message.from,
            message.from!,
            id: 'From: ${message.from}',
          ),
        );
      }
    });
  }

  @override
  void initState() {
    _messageSubscription = _repo.messages.listen(_onMessage);
    super.initState();
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    super.dispose();
  }

  void _onFilterSelected(bool selected, Filter<NetworkMessage> filter) {
    if (!selected) {
      final filters = List<Filter<NetworkMessage>>.from(
        FilterState.of(context).filters,
      );

      filters.removeWhere((x) => x.id == filter.id);

      FilterState.update(
        context,
        FilterState(
          filters: [
            ...filters,
          ],
        ),
      );
    } else {
      FilterState.update(
        context,
        FilterState(
          filters: [
            ...FilterState.of(context).filters,
            filter,
          ],
        ),
      );
    }
  }

  Widget _makeChip(
    Iterable<Filter<NetworkMessage>> filters,
    Filter<NetworkMessage> filter,
  ) {
    return FilterChip(
      shape: StadiumBorder(side: BorderSide(
        width: 1,
      )),
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedColor: ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.background,
        Theme.of(context).colorScheme.surfaceTint,
        4,
      ),
      selected: filters.any((f) => f.id == filter.id),
      label: Text(filter.label),
      onSelected: (v) => _onFilterSelected(v, filter),
    );
  }

  Widget _wrap(Iterable<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Wrap(
        spacing: 6.0,
        children: List.from(children),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterState = FilterState.of(context);
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          i18n.filters,
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(i18n.directionDescription),
              _wrap(
                _direction.map(
                  (x) => _makeChip(filterState.filters, x),
                ),
              ),
              Divider(),
              _sectionTitle(i18n.protocolDescription),
              _wrap(
                _protocol.map(
                  (x) => _makeChip(filterState.filters, x),
                ),
              ),
              Divider(),
              _sectionTitle(i18n.from),
              _wrap(
                _from.map(
                  (x) => _makeChip(filterState.filters, x),
                ),
              ),
              Divider(),
              _sectionTitle(i18n.to),
              _wrap(
                _to.map(
                  (x) => _makeChip(filterState.filters, x),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
