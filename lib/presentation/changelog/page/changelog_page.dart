import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';

class ChangelogPage extends StatefulWidget {
  @override
  State<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends State<ChangelogPage> {
  String? _changes;

  @override
  void initState() {
    final ChangelogService service = sl();

    service.changes().then((changes) {
      setState(() {
        _changes = changes;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = Text(AppLocalizations.of(context)!.whatsNew);
    final child = _changes == null ? Container() : Markdown(data: _changes!);
    final leading = IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        });

      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              leading: leading,
              title: FittedBox(
                child: DefaultTextStyle.merge(
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  child: title,
                ),
              ),
              foregroundColor: Colors.white,
            ),
            SliverFillRemaining(
              child: child,
            ),
          ],
        ),
      );
   
  }
}
