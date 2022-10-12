import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../widgets/feature_unavailable_dialog.dart';

class ServicePage extends StatelessWidget {
  final unlocked = false;

  final Service service;
  final ServiceDescription description;

  const ServicePage({
    Key? key,
    required this.service,
    required this.description,
  }) : super(key: key);

  void _action(BuildContext context, VoidCallback callback) {
    if (!unlocked) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return FeatureUnavailableDialog();
          });
    } else {
      callback();
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(service.serviceId.serviceId),
      ),
      body: Column(
        children: [
          if (description.actionList.actions.isNotEmpty)
            ListTile(
              title: Text(
                i18n.actionsN(description.actionList.actions.length),
              ),
              subtitle: Text(
                description.actionList.actions
                    .map((x) => x.name)
                    .join(i18n.listSeparator),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(Icons.lock_outline),
              onTap: () => _action(
                context,
                () => Application.router!.navigateTo(
                  context,
                  Routes.actionList,
                  routeSettings: RouteSettings(
                    arguments: description.actionList,
                  ),
                ),
              ),
            ),
          if (description.serviceStateTable.stateVariables.isNotEmpty)
            ListTile(
              title: Text(i18n.stateVariablesN(
                  description.serviceStateTable.stateVariables.length)),
              subtitle: Text(
                description.serviceStateTable.stateVariables
                    .map((x) => x.name)
                    .join(i18n.listSeparator),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(Icons.lock_outline),
              onTap: () => _action(
                context,
                () => Application.router!.navigateTo(
                  context,
                  Routes.serviceStateTable,
                  routeSettings: RouteSettings(
                    arguments: description.serviceStateTable,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
