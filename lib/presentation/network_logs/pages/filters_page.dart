import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/application/ioc.dart';
import 'package:upnp_explorer/application/network_logs/composite_specification.dart';
import 'package:upnp_explorer/application/network_logs/network_event_service.dart';

class FiltersPage extends StatefulWidget {
  FiltersPage();

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  final NetworkEventService _service = sl<NetworkEventService>();

  Filters get _filters => _service.filters;

  void _updateFilter(CompositeSpecification spec, bool? value) {
    _service.filter(spec, value ?? false);

    setState(() {});
  }

  Widget _filterGroup(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return ExpansionTile(
        initiallyExpanded: true,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        children: children);
  }

  @override
  Widget build(BuildContext context) {
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
              StreamBuilder(stream: _service.events, builder: (context, snapshot) => ListTile(title: Text('${snapshot.data?.length ?? 0} visible'))),
              _filterGroup(
                context,
                'Direction',
                [
                  CheckboxListTile(
                    title: Text('Received'),
                    value: _filters.received.enabled,
                    onChanged: (v) => _updateFilter(_filters.received, v),
                  ),
                  CheckboxListTile(
                    title: Text('Sent'),
                    value: _filters.sent.enabled,
                    onChanged: (v) => _updateFilter(_filters.sent, v),
                  ),
                ],
              ),
              _filterGroup(
                context,
                'Protocol',
                [
                  CheckboxListTile(
                    title: Text('HTTP'),
                    value: _filters.http.enabled,
                    onChanged: (v) => _updateFilter(_filters.http, v),
                  ),
                  CheckboxListTile(
                    title: Text('SSDP'),
                    value: _filters.ssdp.enabled,
                    onChanged: (v) => _updateFilter(_filters.ssdp, v),
                  ),
                ],
              ),
              _filterGroup(
                context,
                'Type',
                 _filters.type.keys
                    .map(
                      (key) => CheckboxListTile(
                        title: Text(key),
                        value: _filters.type[key]!.enabled,
                        onChanged: (v) => _updateFilter(_filters.type[key]!, v),
                      ),
                    )
                    .toList(),
              ),
              _filterGroup(
                context,
                'From',
                 _filters.from.keys
                    .map(
                      (key) => CheckboxListTile(
                        title: Text(key),
                        value: _filters.from[key]!.enabled,
                        onChanged: (v) => _updateFilter(_filters.from[key]!, v),
                      ),
                    )
                    .toList(),
              ),
              _filterGroup(
                context,
                'To',
                _filters.to.keys
                    .map(
                      (key) => CheckboxListTile(
                        title: Text(key),
                        value: _filters.to[key]!.enabled,
                        onChanged: (v) => _updateFilter(_filters.to[key]!, v),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
