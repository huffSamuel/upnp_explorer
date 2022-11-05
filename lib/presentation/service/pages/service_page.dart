import 'package:flutter/material.dart';
import 'package:upnp_explorer/presentation/core/widgets/row_count.dart';

import '../../../application/application.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../widgets/feature_unavailable_dialog.dart';

class ServicePage extends StatelessWidget {
  final unlocked = true;

  final Service service;
  final ServiceDescription description;

  const ServicePage({
    Key? key,
    required this.service,
    required this.description,
  }) : super(key: key);

  Widget _icon(BuildContext context) {
    return Icon(unlocked ? Icons.chevron_right : Icons.lock_outline);
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(service.serviceId.serviceId),
      ),
      body: Column(
        children: [
          if (description.actionList.actions.isNotEmpty)
            ...description.actionList.actions.map(
              (x) => ListTile(
                title: Text(x.name),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Application.router!.navigateTo(
                  context,
                  Routes.action,
                  routeSettings: RouteSettings(
                    arguments: [
                      x,
                      description.serviceStateTable,
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
