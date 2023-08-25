import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeatureUnavailableDialog extends StatelessWidget {
  const FeatureUnavailableDialog();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

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
