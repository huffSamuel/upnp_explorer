import 'package:flutter/material.dart';
import '../../../core/light.dart';
import '../../../../application/l10n/app_localizations.dart';
import '../../../core/presentation/widgets/my_card.dart';

class ChangesHintCard extends StatelessWidget {
  const ChangesHintCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = AppLocalizations.of(context)!;

    final myColors = theme.extension<MyCustomColors>()!;

    return MyCard(
      color:
          ElevationOverlay.applySurfaceTint(theme.cardColor, myColors.brandSuccess, 2),
      highlight: myColors.brandSuccess,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: myColors.brandSuccess),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium!.copyWith(
                    letterSpacing: -.25,
                    height: 1.25,
                    color: myColors.brandSuccess),
                children: [
                  TextSpan(
                      text: 'Note: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(
                      text:
                          'Changes to discovery settings will only take effect on the next scan. Aggressive settings may cause network congestion in some environments.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
