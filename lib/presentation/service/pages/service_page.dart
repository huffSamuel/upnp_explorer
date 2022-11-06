import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/models/service_description.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.serviceId.serviceId),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text('View XML'),
              )
            ],
            onSelected: (value) {
              if (value == 0) {
                Application.router!.navigateTo(
                  context,
                  Routes.document,
                  routeSettings: RouteSettings(
                    arguments: description.xml,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          if (description.actionList.actions.isNotEmpty)
            ...description.actionList.actions.map(
              (x) => ListTile(
                title: Text(x.name),
                trailing: _icon(context),
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
