import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../../core/page/app_page.dart';
import 'action_page.dart';

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
    final children = List<Widget>.of(
      actionList.actions.map(
        (x) => ListTile(
          title: Text(x.name),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            makeRoute(
              context,
              ActionPage(
                action: x,
                stateTable: stateTable,
              ),
            ),
          ),
        ),
      ),
    );

    return AppPage(
      title: Text(AppLocalizations.of(context)!.actions),
      children: children,
    );
  }
}
