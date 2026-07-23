import 'package:flutter/material.dart';

import '../../../../application/l10n/app_localizations.dart';

class ClearMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(i18n.clearMessages),
      content: Text(i18n.thisWillClearAllMessages),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: DefaultTextStyle.merge(
            style: TextStyle(fontSize: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Clear all messages'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: DefaultTextStyle.merge(
            style: TextStyle(fontSize: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Keep Messages'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
