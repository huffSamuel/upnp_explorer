import 'package:flutter/material.dart';

import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../domain/changelog/change_version.dart';
import '../../core/page/app_page.dart';

class ChangelogPage extends StatefulWidget {
  @override
  State<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends State<ChangelogPage> {
  bool _loading = true;
  late List<ChangeVersion> _changes;

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
    List<Widget> children;

    if (_loading) {
      children = [Container()];
    } else {
      children = [];

      for (var i = 0; i < _changes.length; ++i) {
        children.add(_ChangelogVersion(change: _changes[i], current: i == 0));
      }
    }

    return AppPage(
      title: Text(S.of(context).whatsNew),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        }
      ),
      children: children,
    );
  }
}

class _ChangelogVersion extends StatelessWidget {
  final bool current;
  final ChangeVersion change;

  const _ChangelogVersion({
    Key? key,
    required this.change,
    this.current = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    var titleTheme = textTheme.titleLarge!;
    var bodyTheme = textTheme.bodyMedium!;

    if (current) {
      titleTheme = titleTheme.copyWith(fontWeight: FontWeight.w500);

      bodyTheme = bodyTheme.copyWith(
        fontWeight: FontWeight.w500,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 8.0,
        bottom: 16.0,
        top: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(change.version, style: titleTheme),
          const SizedBox(height: 4.0),
          ...change.changes.map(
            (x) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                S.of(context).changelogItem(x),
                style: bodyTheme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
