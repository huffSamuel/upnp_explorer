import 'package:flutter/material.dart';
import 'package:upnp_explorer/version.dart';
import '../../../../application/l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import '../../../../application/flavors/flavor_features.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/application.dart';
import '../../../../application/bug_report_service.dart';
import '../../../../application/ioc.dart';
import '../../../../application/routing/routes.dart';
import '../../../changelog/page/changelog_page.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings_category_page.dart';
import '../../widgets/settings_category_tile.dart';
import '../../widgets/version_text.dart';
import 'contributors_page.dart';

class AboutSettingsPage extends StatelessWidget {
  const AboutSettingsPage();

  Function() _openPage(BuildContext context, Widget page) {
    return () => Navigator.of(context).push(
          makeRoute(context, page),
        );
  }

  void _openSource(BuildContext c) async {
    launchUrl(Application.repoUri);
  }

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

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final flavor = GetIt.instance.get<FlavorFeatures>();

    return SettingsCategoryPage(
      category: i18n.about,
      children: [
        if (flavor.showRatingTile)
          SettingsTile(
            leading: Icon(Icons.rate_review_outlined),
            title: Text(i18n.rateOnGooglePlay),
            subtitle: Text(i18n.letUsKnowHowWereDoing),
            onTap: () => flavor.openStoreListing(),
          ),
        SettingsTile(
          leading: Icon(Icons.history_rounded),
          title: Text(i18n.changelog),
          subtitle: VersionText(),
          onTap: _openPage(
            context,
            ChangelogPage(),
          ),
        ),
        SettingsDivider(),
        SettingsTile(
          leading: Icon(Icons.code),
          title: Text(i18n.wereOpenSource),
          subtitle: Text(i18n.viewSourceCode),
          onTap: () => _openSource(context),
        ),
        SettingsTile(
          title: Text(i18n.contributors),
          subtitle: Text(i18n.aSpecialThanks),
          leading: Icon(Icons.commit_rounded),
          onTap: _openPage(
            context,
            ContributorsPage(),
          ),
        ),
        SettingsTile(
          leading: Icon(Icons.bug_report_outlined),
          title: Text(i18n.foundBug),
          subtitle: Text(i18n.openAnIssueOnOurGithub),
          onTap: () => _submitBug(context),
        ),
        SettingsDivider(),
        SettingsTile(
          leading: Icon(Icons.privacy_tip_outlined),
          title: Text(i18n.privacyPolicy),
          onTap: () => launchUrl(Application.privacyPolicyUri),
        ),
        SettingsTile(
          title: Text(i18n.licenses),
          onTap: _openPage(
            context,
            LicensePage(),
          ),
        ),
        SettingsDivider(),
        AboutTile(
          child: Text(i18n.legalese),
        )
      ],
    );
  }
}
