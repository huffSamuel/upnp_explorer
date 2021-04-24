import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../constants.dart';
import '../../../data/options.dart';
import '../../../domain/value_converter.dart';
import '../../../generated/l10n.dart';
import '../widgets/choose_theme_dialog.dart';
import '../widgets/visual_density_dialog.dart';
import 'max_delay_page.dart';
import 'multicast_hops_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(i18n.settings)),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SettingsList(
          lightBackgroundColor: ThemeData.light().canvasColor,
          darkBackgroundColor: ThemeData.dark().canvasColor,
          sections: [
            SettingsSection(
              title: i18n.display,
              tiles: [
                SettingsTile(
                  title: i18n.theme,
                  trailing: Text(i18n.themeMode(options.themeMode)),
                  onPressed: (context) => showThemeDialog(context),
                ),
                SettingsTile(
                  title: i18n.density,
                  onPressed: (context) => showVisualDensityDialog(context),
                  trailing: Text(
                    i18n.visualDensity(
                      kVisualDensityConverter.from(options.visualDensity),
                    ),
                  ),
                )
              ],
            ),
            SettingsSection(
              title: i18n.ssdpProtocol,
              tiles: [
                SettingsTile(
                  title: i18n.maxResponseDelay,
                  trailing: Text(
                      i18n.responseDelay(options.protocolOptions.maxDelay)),
                  onPressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => MaxResponseDelayPage(),
                    ),
                  ),
                ),
                SettingsTile(
                  title: i18n.multicastHops,
                  trailing: Text(options.protocolOptions.hops.toString()),
                  onPressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => MulticastHopsPage(),
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
                  onPressed: (_) => print(i18n.submitBug),
                ),
                SettingsTile(
                  title: i18n.aboutApp(kAppName),
                  onPressed: _showAboutDialog,
                ),
              ],
            ),
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
