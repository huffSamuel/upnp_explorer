import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/application.dart';
import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/app_localizations.dart';

class ChangelogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.large(
            floating: true,
            forceMaterialTransparency: false,
            pinned: true,
            leading: const _CloseButton(),
            title: FittedBox(
              child: Text(AppLocalizations.of(context)!.whatsNew),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const _ChangelogMarkdown(),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class _ChangelogMarkdown extends StatelessWidget {
  const _ChangelogMarkdown();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return StreamBuilder(
      stream: sl<ChangelogService>().changes(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text(i18n.unableToLoadChangelog),
                SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () => launchUrl(Application.changelogUri),
                    child: Text(i18n.viewInBrowser))
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          child: AnimatedCrossFade(
            firstChild: Center(child: LinearProgressIndicator()),
            secondChild: Builder(
              builder: (context) => snapshot.data == null
                  ? Container()
                  : MarkdownBody(data: snapshot.data!),
            ),
            crossFadeState: snapshot.hasData
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(
              milliseconds: 275,
            ),
            sizeCurve: Curves.easeIn,
            firstCurve: Curves.easeIn,
            secondCurve: Curves.easeOut,
          ),
        );
      },
    );
  }
}
