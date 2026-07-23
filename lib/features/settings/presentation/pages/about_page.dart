import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/application.dart';
import '../../../../application/bug_report_service.dart';
import '../../../../application/ioc.dart';
import '../../../../application/l10n/app_localizations.dart';
import '../../../core/presentation/pages/changelog_page.dart';
import '../../../core/presentation/widgets/my_bottom_app_bar.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../../../version.dart';
import '../widgets/version_text.dart';
import 'contributors_page.dart';

class AboutSettingsPage extends StatelessWidget {
  void _submitBug(BuildContext c) async {
    final i18n = AppLocalizations.of(c)!;
    final bugService = sl<BugReportService>();

    bugService.submitBug(
      i18n.mailSubject,
      i18n.mailBody(version),
      () {
        final snackbar = SnackBar(
          content: Text(i18n.unableToSubmitFeedback),
        );
        ScaffoldMessenger.of(c).showSnackBar(snackbar);
      },
    );
  }

  void _openSource(BuildContext c) async {
    launchUrl(Application.repoUri);
  }

  void _openPrivacyPolicy() {
    launchUrl(Application.privacyPolicyUri);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: MyBottomAppBar(currentIndex: 2),
      appBar: AppBar(
        title: PageTitle(child: Text('Settings')),
      ),
      body: ListView(
        children: [
          MyCard(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SizedBox(height: 64, width: 64, child: Placeholder()),
                const SizedBox(height: 16),
                Text(
                  'UPnP Explorer',
                  style: TextTheme.of(context).bodyMedium!.copyWith(
                        fontSize: 32,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -.3,
                      ),
                ),
                DefaultTextStyle.merge(
                    style: TextStyle(
                        color: theme.hintColor,
                        fontSize: 16,
                        letterSpacing: -.2),
                    child: VersionText())
              ],
            ),
          ),
          MyCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Rate on Google Play'),
                    trailing: Icon(Icons.open_in_new)),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('View Changelog'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => ChangelogPage())),
                )
              ],
            ),
          ),
          MyCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(Icons.commit),
                      title: Text('View Contributors'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => ContributorsPage()))),
                  ListTile(
                    leading: Icon(Icons.code),
                    title: Text('View Source Code'),
                    trailing: Icon(Icons.open_in_new),
                    onTap: () => _openSource(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text('Submit a Bug'),
                    trailing: Icon(Icons.open_in_new),
                    onTap: () => _submitBug(context),
                  )
                ],
              )),
          MyCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.open_in_new),
                  onTap: _openPrivacyPolicy,
                ),
                ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Open Source Licenses'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => LicensePage())))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
