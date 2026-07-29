import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../application/contributor_service.dart';
import '../../../../application/ioc.dart';
import '../../../../application/l10n/app_localizations.dart';
import '../../../../packages/github/contributor.dart';

class ContributorsPage extends StatefulWidget {
  const ContributorsPage({super.key});

  @override
  State<ContributorsPage> createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
  final _s = sl<ContributorsService>();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(i18n.contributors)),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: _s.contributors(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Center(child: CircularProgressIndicator());
                }

                final contributors = snapshot.data!.toList();

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: _ContributorListTile(
                      contributor: contributors[index],
                    ),
                  ),
                  itemCount: snapshot.data!.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContributorListTile extends StatelessWidget {
  final Contributor contributor;

  const _ContributorListTile({required this.contributor});

  @override
  Widget build(BuildContext context) {
    final image = Image(image: NetworkImage(contributor.avatarUrl));

    final clippedImage =
        contributor.type == UserType.user ? ClipOval(child: image) : image;

    return ListTile(
      onTap: () => launchUrlString(contributor.profileUrl),
      leading: clippedImage,
      title: Text(contributor.login),
    );
  }
}
