import 'package:fl_upnp/fl_upnp.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/routing/routes.dart';
import '../../core/page/app_page.dart';
import 'action_page.dart';

class ActionsPage extends StatelessWidget {
  final List<ServiceAction> actions;
  final ServiceStateTable stateTable;

  const ActionsPage({
    Key? key,
    required this.actions,
    required this.stateTable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>.of(
      actions.map(
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
