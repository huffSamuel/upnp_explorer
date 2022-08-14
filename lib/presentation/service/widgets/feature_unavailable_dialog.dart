import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';

class FeatureUnavailableDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return AlertDialog(
      title: Text(i18n.unavailable),
      content: Text(
        i18n.serviceControlUnavailable,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(i18n.ok),
        ),
      ],
    );
  }
}
