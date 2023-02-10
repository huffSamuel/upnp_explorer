import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/application.dart';
import '../../../../application/ioc.dart';
import '../../../../application/routing/routes.dart';
import '../../../../infrastructure/core/bug_report_service.dart';
import '../../../changelog/page/changelog_page.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings_category_page.dart';
import '../../widgets/settings_category_tile.dart';
import '../../widgets/version_text.dart';

class AboutSettingsPage extends StatelessWidget {
  Function() _openPage(BuildContext context, Widget page) {
    return () => Navigator.of(context).push(
          makeRoute(context, page),
        );
  }

  void _submitBug(BuildContext c) async {
    final i18n = AppLocalizations.of(c)!;
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

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return SettingsCategoryPage(
      category: i18n.about,
      children: [
        SettingsTile(
          leading: Icon(Icons.rate_review_outlined),
          title: Text(i18n.rateOnGooglePlay),
          subtitle: Text(i18n.letUsKnowHowWereDoing),
          onTap: () => InAppReview.instance
              .openStoreListing(appStoreId: Application.appId),
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
          onTap: () => launchUrl(
            Uri.parse(
              Application.privacyPolicyUrl,
            ),
          ),
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
