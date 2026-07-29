import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';
import '../../../../application/ioc.dart';
import '../../../../application/network_logs/network_event_service.dart';
import 'package:upnped/upnped.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  final _service = sl<NetworkEventService>();
  
  late List<String> _types;
  late final TextEditingController _ipController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _types = [..._service.filter.eventTypes];
    _ipController = TextEditingController(text: _service.filter.ipAddress);


    super.initState();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _service.setFilter(NetworkEventFilter(eventTypes: _types, ipAddress: _ipController.text));
      Navigator.of(context).pop();
    }
  }

  void _reset() {
    _service.setFilter(NetworkEventFilter());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                i18n.filters,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -.3,
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                i18n.filterByType.toUpperCase(),
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: theme.hintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...NetworkEventType.all.map(
                    (x) => ChoiceChip(
                      label: Text(x),
                      visualDensity: VisualDensity.compact,
                      showCheckmark: false,
                      selected: _types.contains(x),
                      onSelected: (v) {
                        if (v) {
                          setState(() {
                            _types.add(x);
                          });
                        } else {
                          setState(() {
                            _types.remove(x);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                i18n.filterByIp.toUpperCase(),
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: theme.hintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                controller: _ipController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    try {
                      Uri.parseIPv4Address(value);
                    } on FormatException {
                      return i18n.invalidIpAddress;
                    }
                  }
      
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                onPressed: _submit,
                child: DefaultTextStyle.merge(
                  style: TextStyle(fontSize: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(i18n.applyFilters),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  )
                ),
                onPressed: _reset,
                child: DefaultTextStyle.merge(
                  style: TextStyle(fontSize: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(i18n.resetFilters),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
