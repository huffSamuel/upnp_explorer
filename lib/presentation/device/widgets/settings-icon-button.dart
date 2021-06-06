import 'package:flutter/material.dart';
import 'package:upnp_explorer/presentation/settings/pages/settings-page.dart';

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
