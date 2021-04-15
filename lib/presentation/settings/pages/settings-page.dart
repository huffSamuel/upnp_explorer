import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:ssdp/domain/value_converter.dart';

import '../../../constants.dart';
import '../../../data/options.dart';
import '../../../generated/l10n.dart';
import '../widgets/choose_theme_dialog.dart';
import '../widgets/visual_density_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(i18n.settings)),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: i18n.display,
            tiles: [
              SettingsTile(
                title: i18n.theme,
                trailing: Text(i18n.themeMode(Options.of(context).themeMode)),
                onPressed: (context) => showThemeDialog(context),
              ),
              SettingsTile(
                title: i18n.density,
                onPressed: (context) => showVisualDensityDialog(context),
                trailing: Text(
                  i18n.visualDensity(
                    kVisualDensityConverter
                        .from(Options.of(context).visualDensity),
                  ),
                ),
              )
            ],
          ),
          SettingsSection(
            title: i18n.about,
            tiles: [
              SettingsTile(
                title: i18n.submitBug,
                onPressed: (_) => print(S.of(context).submitBug),
              ),
              SettingsTile(
                title: i18n.aboutApp(kAppName),
                onPressed: _showAboutDialog,
              ),
            ],
          ),
          SettingsSection(
            title: i18n.ssdpProtocol,
            tiles: [
              SettingsTile(
                title: i18n.maxWaitResponseTime,
                onPressed: (_) => print('response time'),
              ),
              SettingsTile(
                title: i18n.multicastHops,
                onPressed: (_) => print('Multicast Hops'),
              )
            ],
          )
        ],
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
