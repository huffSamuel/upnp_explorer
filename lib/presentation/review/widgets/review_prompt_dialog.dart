import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/application.dart';
import '../../../application/review/review_service.dart';

class ReviewPromptDialog extends StatelessWidget {
  void Function() _pop(BuildContext context, ReviewResponse response) {
    return () => Navigator.of(context).pop(response);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(i18n.rateAppName(Application.name)),
      content: Text(i18n.pleaseRateAppName(Application.name)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: _pop(context, ReviewResponse.notNow),
              child: Text(i18n.notNow),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _pop(context, ReviewResponse.ok),
                  child: Text(i18n.rateAppName(Application.name)),
                ),
                TextButton(
                  onPressed: _pop(context, ReviewResponse.never),
                  child: Text(i18n.neverAskAgain),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
