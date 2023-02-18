import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../core/page/app_page.dart';

class ChangelogPage extends StatefulWidget {
  @override
  State<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends State<ChangelogPage> {
  bool _loading = true;
  late String _changes;

  @override
  void initState() {
    final ChangelogService service = sl();

    service.changes().then((changes) {
      setState(() {
        _loading = false;
        _changes = changes;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: Text(AppLocalizations.of(context)!.whatsNew),
      leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      children: [Container()],
      sliver: _loading
          ? null
          : SliverFillRemaining(child: Markdown(data: _changes)),
    );
  }
}