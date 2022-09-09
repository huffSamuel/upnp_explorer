import 'package:flutter/material.dart';

import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../domain/changelog/change_version.dart';

void maybeShowChangelogDialog(BuildContext context) {
  final ChangelogService svc = sl();

  svc.shouldDisplayChangelog().then(
    (display) {
      if (display) {
        showChangelogDialog(context);
      }
    },
  );
}

void showChangelogDialog(BuildContext context) {
  final ChangelogService svc = sl();

  svc.changes().then(
        (changes) => showDialog(
          context: context,
          builder: (context) {
            return ChangelogDialog(changes: changes);
          },
        ),
      );
}

class ChangelogDialog extends StatelessWidget {
  final List<ChangeVersion> changes;

  const ChangelogDialog({Key? key, required this.changes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("What's New"),
      contentPadding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      content: Container(
        width: double.maxFinite,
        child: Scrollbar(
          child: ListView.separated(
            itemCount: changes.length,
            itemBuilder: ((context, index) =>
                _ChangelogVersion(change: changes[index])),
            separatorBuilder: (_, __) => const SizedBox(height: 8.0),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: Text('Ok'))
      ],
    );
  }
}

class _ChangelogVersion extends StatelessWidget {
  final ChangeVersion change;

  const _ChangelogVersion({Key? key, required this.change}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(change.version, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4.0),
          ...change.changes.map((x) =>
              Text('- ' + x, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}
