import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/contributor_service.dart';
import '../../../../application/ioc.dart';
import '../../../../packages/github/contributor.dart';
import '../../../core/page/app_page.dart';

class ContributorsPage extends StatefulWidget {
  @override
  State<ContributorsPage> createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
  final _s = sl<ContributorsService>();

  @override
  void initState() {
    super.initState();
    _s.load();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return StreamBuilder(
        stream: _s.contributors$,
        builder: (context, snapshot) {
          return AppPage(
            title: Text(i18n.contributors),
            children: [
              if (!snapshot.hasData ||
                  (snapshot.hasData && snapshot.data!.isEmpty))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (snapshot.hasData)
                SingleChildScrollView(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Wrap(
                      spacing: 4.0,
                      children: snapshot.data!
                          .map(
                            (x) => SizedBox(
                              width: (constraints.maxWidth - 12) / 3,
                              child: _Contributor(
                                contributor: x,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }),
                )
            ],
          );
        });
  }
}

class _Contributor extends StatelessWidget {
  final Contributor contributor;

  const _Contributor({super.key, required this.contributor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(contributor.profileUrl)),
      child: Column(
        children: [
          Image(
            image: NetworkImage(contributor.avatarUrl),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.loose(Size.fromWidth(128)),
            child: Text(
              contributor.login,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
