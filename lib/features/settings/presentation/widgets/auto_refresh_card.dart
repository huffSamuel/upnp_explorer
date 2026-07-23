import 'package:flutter/material.dart';
import '../../../../application/l10n/app_localizations.dart';
import '../../../core/presentation/widgets/my_card.dart';

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
    final theme = Theme.of(context);
    final i18n = AppLocalizations.of(context)!;

    return MyCard(
      child: Column(
        children: [
          Row(children: [
            Icon(
              Icons.refresh,
              color: theme.colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'Auto-refresh',
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -.3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ]),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: theme.hintColor,
                  ),
                  child: Text(
                    'Automatically trigger a scan when opening the app.',
                  ),
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
