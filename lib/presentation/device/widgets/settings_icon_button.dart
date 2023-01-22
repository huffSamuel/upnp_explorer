import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../settings/pages/settings_page.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).settings,
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
