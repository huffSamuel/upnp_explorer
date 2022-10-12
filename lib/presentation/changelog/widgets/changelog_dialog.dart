import 'package:flutter/material.dart';

import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
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
    final i18n = S.of(context);

    return SimpleDialog(
      title: Text(i18n.whatsNew),
      children: [
        Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Scrollbar(
            child: ListView.separated(
              itemCount: changes.length,
              itemBuilder: (context, index) => _ChangelogVersion(
                current: index == 0,
                change: changes[index],
              ),
              separatorBuilder: (_, __) => const Divider(
                height: 16.0,
                thickness: 1.5,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(i18n.ok),
            ),
          ],
        ),
      ],
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

    var titleTheme = textTheme.titleMedium!;
    var bodyTheme = textTheme.bodyMedium!;

    if (current) {
      titleTheme = titleTheme.copyWith(fontWeight: FontWeight.w500);

      bodyTheme = bodyTheme.copyWith(
        fontWeight: FontWeight.w500,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(change.version, style: titleTheme),
          const SizedBox(height: 4.0),
          ...change.changes.map(
            (x) => Text(
              S.of(context).changelogItem(x),
              style: bodyTheme,
            ),
          ),
        ],
      ),
    );
  }
}
