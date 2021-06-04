import 'package:flutter/material.dart';
import 'package:upnp_explorer/generated/l10n.dart';

void showAvailableInproDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AvailableInProDialog(),
    );

class AvailableInProDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    final children = [
      Text(i18n.featureOnlyAvailableInPro),
      Row(
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              i18n.ok,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              i18n.viewInStore,
            ),
          ),
        ],
      ),
    ];

    return SimpleDialog(
      title: Text(i18n.onlyAvailableInPro),
      children: children,
    );
  }
}
