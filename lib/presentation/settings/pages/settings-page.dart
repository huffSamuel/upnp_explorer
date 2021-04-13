import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: i18n.display,
              tiles: [
                SettingsTile(
                  title: i18n.theme,
                ),
                SettingsTile(title: i18n.density)
              ],
            ),
            SettingsSection(
              title: i18n.about,
              tiles: [
                SettingsTile(
                  title: i18n.submitBug,
                  onPressed: (_) => print('Submit Bug'),
                ),
                SettingsTile(
                  title: i18n.aboutApp('SSDB Browser'),
                  onPressed: _showAboutDialog,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext c) async {
    final i18n = S.of(c);
    final info = await PackageInfo.fromPlatform();

    showAboutDialog(
      context: c,
      applicationName: info.appName,
      applicationVersion: i18n.version(info.version),
    );
  }
}
