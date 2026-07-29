import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';

import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/section_header.dart';
import 'setting_description.dart';

class AutoRefreshCard extends StatefulWidget {
  final bool value;
  final void Function(bool? value)? onChanged;

  const AutoRefreshCard({
    super.key,
    this.onChanged,
    required this.value,
  });

  @override
  State<AutoRefreshCard> createState() => _AutoRefreshCardState();
}

class _AutoRefreshCardState extends State<AutoRefreshCard> {
  void _onChanged(bool value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    return MyCard(
      child: Column(
        children: [
          SectionHeader(
            icon: Icon(Icons.refresh),
            title: Text(i18n.autoRefresh),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SettingDescription(
                  child: Text(i18n.autoRefreshDescription),
                ),
              ),
              Switch(
                value: widget.value,
                onChanged: _onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
