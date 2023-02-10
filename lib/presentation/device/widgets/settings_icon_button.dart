import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../settings/pages/settings_page.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)!.settings,
      icon: Icon(Icons.settings),
      color: Theme.of(context).appBarTheme.foregroundColor,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) => MaterialDesignSettingsPage(),
        ),
      ),
    );
  }
}
