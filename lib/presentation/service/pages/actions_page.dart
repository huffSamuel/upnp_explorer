import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../infrastructure/upnp/service_description.dart';

class ActionsPage extends StatelessWidget {
  final ActionList actionList;

  const ActionsPage({
    Key? key,
    required this.actionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).actions),
      ),
      body: Column(
        children: [
          ...actionList.actions.map(
            (x) => ListTile(
              title: Text(x.name),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}
