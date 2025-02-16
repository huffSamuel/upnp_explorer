import 'package:flutter/material.dart';

import '../../../application/l10n/app_localizations.dart';
import '../../../application/routing/routes.dart';
import '../../settings/pages/settings_page.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)!.settings,
      icon: const Icon(Icons.settings),
      onPressed: () => Navigator.of(context).push(
        makeRoute(
          context,
          MaterialDesignSettingsPage(),
          direction: TransitionDirection.fromLeft,
        ),
      ),
    );
  }
}
