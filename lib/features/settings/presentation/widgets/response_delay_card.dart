import 'package:flutter/material.dart';

import '../../../../application/l10n/app_localizations.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/number_input.dart';
import '../../../control/presentation/widgets/my_field.dart';

class ResponseDelayCard extends StatelessWidget {
  final TextEditingController controller;

  const ResponseDelayCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = AppLocalizations.of(context)!;

    return MyCard(
      child: Column(
        children: [
          Row(children: [
            Icon(Icons.timer, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: 12),
            Text(
              'Response Delay',
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -.3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ]),
          const SizedBox(height: 16),
          MyField(
            label: Text('Seconds'),
            child: NumberInput(controller: controller),
          ),
          const SizedBox(height: 16),
          DefaultTextStyle.merge(
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: theme.hintColor,
              height: 1.3,
            ),
            child: Text(
              i18n.maxDelayDescription,
            ),
          ),
        ],
      ),
    );
  }
}
