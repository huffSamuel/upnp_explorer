import 'package:flutter/material.dart';

import '../../settings/pages/settings_page.dart';

class SettingsIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) => SettingsPage(),
        ),
      ),
    );
  }
}
