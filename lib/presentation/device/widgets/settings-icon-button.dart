import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../settings/pages/settings_page.dart';

class SettingsIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).settings,
      icon: Icon(Icons.settings),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) => SettingsPage(),
        ),
      ),
    );
  }
}
