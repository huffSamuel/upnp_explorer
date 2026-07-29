import 'package:flutter/material.dart';

import '../../../../extension/build_context.dart';
import '../../../core/custom_colors.dart';
import '../../../core/presentation/widgets/my_card.dart';

class ChangesHintCard extends StatelessWidget {
  const ChangesHintCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    final myColors = theme.extension<MyCustomColors>()!;

    return MyCard(
      color: ElevationOverlay.applySurfaceTint(
          theme.cardColor, myColors.brandSuccess, 2),
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
                      text: i18n.note,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: i18n.protocolSettingsNote),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
