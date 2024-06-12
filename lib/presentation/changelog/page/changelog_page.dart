import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';

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
    return StreamBuilder(
      stream: sl<ChangelogService>().changes(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // could not load, display a "we're sorry" with a link to the changelog
          return Container();
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return MarkdownBody(data: snapshot.data!);
      },
    );
  }
}
