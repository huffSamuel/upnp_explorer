import 'package:flutter/material.dart';

import '../../../application/network_logs/property_filter.dart';

class FilterGroupExpansionTile<T> extends StatelessWidget {
  final String title;
  final Set<T>? allowedValues;
  final PropertyFilter<T>? filter;
  final Map<T, String>? titleResolver;
  final void Function(T value, bool enabled) onChanged;

  const FilterGroupExpansionTile({
    super.key,
    required this.title,
    required this.allowedValues,
    required this.filter,
    required this.onChanged,
    this.titleResolver,
  });

  String _resolveTitle(T value) {
    return titleResolver?[value] ?? value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        if (filter != null && allowedValues != null)
          ...allowedValues!.map(
            (x) => CheckboxListTile(
              title: Text(_resolveTitle(x)),
              value: filter!.isEnabled(x),
              onChanged: (v) => onChanged(x, v == true),
            ),
          ),
      ],
    );
  }
}
