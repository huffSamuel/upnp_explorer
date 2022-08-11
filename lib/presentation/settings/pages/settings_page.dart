import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:upnp_explorer/presentation/settings/pages/search_target_page.dart';

import '../../../application/application.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/settings/options.dart';
import '../../../domain/value_converter.dart';
import '../../../infrastructure/core/bug_report_service.dart';
import '../widgets/choose_theme_dialog.dart';
import '../widgets/visual_density_dialog.dart';
import 'max_delay_page.dart';
import 'multicast_hops_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    return AnimatedTheme(
      data: Theme.of(context),
      curve: Curves.easeIn,
      child: Scaffold(
        appBar: AppBar(title: Text(i18n.settings)),
        body: SettingsList(
          lightTheme: SettingsThemeData(
            settingsListBackground: ThemeData.light().canvasColor,
          ),
          darkTheme: SettingsThemeData(
            settingsListBackground: ThemeData.dark().canvasColor,
          ),
          sections: [
            SettingsSection(
              title: Text(i18n.display),
              tiles: [
                SettingsTile(
                  title: Text(i18n.theme),
                  trailing: Text(i18n.themeMode(options.themeMode)),
                  onPressed: (context) => showThemeDialog(context),
                ),
                SettingsTile(
                  title: Text(i18n.density),
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
              title: Text(i18n.ssdpProtocol),
              tiles: [
                SettingsTile(
                  title: Text(i18n.maxResponseDelay),
                  trailing: Text(
                      i18n.responseDelay(options.protocolOptions.maxDelay)),
                  onPressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => MaxResponseDelayPage(),
                    ),
                  ),
                ),
                SettingsTile(
                  title: Text(i18n.multicastHops),
                  trailing: Text(options.protocolOptions.hops.toString()),
                  onPressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => MulticastHopsPage(),
                    ),
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: Text(i18n.about),
              tiles: [
                SettingsTile(
                  title: Text(i18n.submitBug),
                  onPressed: _submitBug,
                ),
                SettingsTile(
                  title: Text(i18n.aboutApp(Application.name)),
                  onPressed: _showAboutDialog,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitBug(BuildContext c) async {
    final i18n = S.of(c);
    final bugService = sl<BugReportService>();
    final info = await PackageInfo.fromPlatform();

    bugService.submitBug(
      i18n.mailSubject,
      i18n.mailBody(info.version),
      () {
        final snackbar = SnackBar(
          content: Text(i18n.unableToSubmitFeedback),
        );
        ScaffoldMessenger.of(c).showSnackBar(snackbar);
      },
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
