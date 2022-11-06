import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/service_description.dart';

class ActionsPage extends StatelessWidget {
  final ActionList actionList;
  final ServiceStateTable stateTable;

  const ActionsPage({
    Key? key,
    required this.actionList,
    required this.stateTable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).actions),
      ),
      body: _Actions(
        actionList: actionList,
        stateTable: stateTable,
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final ActionList actionList;
  final ServiceStateTable stateTable;

  const _Actions({
    Key? key,
    required this.actionList,
    required this.stateTable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...actionList.actions.map(
          (x) => ListTile(
            title: Text(x.name),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Application.router!.navigateTo(
              context,
              Routes.action,
              routeSettings: RouteSettings(
                arguments: [
                  x,
                  stateTable,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
