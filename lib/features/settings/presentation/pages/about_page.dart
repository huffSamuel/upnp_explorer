import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/application.dart';
import '../../../../application/bug_report_service.dart';
import '../../../../application/ioc.dart';
import '../../../../application/l10n/app_localizations.dart';
import '../../../../version.dart';
import '../../../core/presentation/pages/changelog_page.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../widgets/version_text.dart';
import 'contributors_page.dart';

class AboutSettingsPage extends StatelessWidget {
  const AboutSettingsPage({super.key});

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
    final i18n = context.i18n();

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(child: Text(i18n.settings)),
      ),
      body: ListView(
        children: [
          MyCard(
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(height: 64, width: 64, child: Image.asset('assets/ic_launcher/ic_launcher.png')),
                const SizedBox(height: 16),
                Text(
                  Application.name,
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
                    title: Text(i18n.rateOnGooglePlay),
                    trailing: Icon(Icons.open_in_new)),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text(i18n.viewChangelog),
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
                      title: Text(i18n.viewContributors),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => ContributorsPage()))),
                  ListTile(
                    leading: Icon(Icons.code),
                    title: Text(i18n.viewSourceCode),
                    trailing: Icon(Icons.open_in_new),
                    onTap: () => _openSource(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text(i18n.submitABug),
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
                  title: Text(i18n.privacyPolicy),
                  trailing: Icon(Icons.open_in_new),
                  onTap: _openPrivacyPolicy,
                ),
                ListTile(
                    leading: Icon(Icons.description),
                    title: Text(i18n.openSourceLicenses),
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
