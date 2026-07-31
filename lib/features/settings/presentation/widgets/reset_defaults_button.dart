import 'package:flutter/material.dart';

import '../../../../extension/build_context.dart';

class ResetToDefaultsCard extends StatelessWidget {
  final VoidCallback? onPressed;

  const ResetToDefaultsCard({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            foregroundColor: theme.colorScheme.onSurface),
        onPressed: onPressed,
        child: DefaultTextStyle.merge(
          style: TextStyle(fontSize: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, size: 24),
              const SizedBox(width: 4),
              Text(i18n.resetToDefaults),
            ],
          ),
        ),
      ),
    );
  }
}
