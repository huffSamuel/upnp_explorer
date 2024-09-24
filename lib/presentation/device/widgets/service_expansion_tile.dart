import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnped/upnped.dart' as upnp;

import '../../../application/routing/routes.dart';
import '../../service/pages/action_page.dart';
import 'leading_icon_builder.dart';
import 'tile_insets.dart';

class ServiceExpansionTile extends StatelessWidget {
  final upnp.Service service;
  final int depth;

  const ServiceExpansionTile({
    super.key,
    required this.service,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: tileInsets(depth),
      title: Text(service.document.serviceId.serviceId),
      leading: SizedBox(
        height: 40,
        width: 40,
        child: Icon(Icons.account_tree_outlined),
      ),
      children: [
        if (service.description?.actions.isEmpty == true)
          ListTile(
            title: Text(AppLocalizations.of(context)!.noActionsForThisService),
            leading: LeadingIconBuilder(
              builder: (context) => Icon(Icons.warning_amber_rounded),
            ),
          ),
        if (service.description != null)
          ...service.description!.actions.map(
            (x) => _ActionListTile(
              action: x,
              serviceStateTable: service.description!.serviceStateTable,
            ),
          ),
        if (service.description == null)
          ListTile(
            title: Text(AppLocalizations.of(context)!.nothingHere),
            leading: LeadingIconBuilder(
              builder: (context) => Icon(Icons.warning_amber_rounded),
            ),
          ),
      ],
    );
  }
}

class _ActionListTile extends StatelessWidget {
  final upnp.Action action;
  final upnp.ServiceStateTable serviceStateTable;

  const _ActionListTile({
    super.key,
    required this.action,
    required this.serviceStateTable,
  });

  void _navigateToAction(BuildContext context) => Navigator.of(context).push(
        makeRoute(
          context,
          ActionPage(
            action: action,
            stateTable: serviceStateTable,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(action.name),
        leading: LeadingIconBuilder(
          builder: (context) => Icon(Icons.sync_alt),
        ),
        onTap: () => _navigateToAction(context),
      );
}
