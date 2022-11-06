import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../../../infrastructure/upnp/models/service_description.dart' as upnp;

class ServicePage extends StatelessWidget {
  final Service service;
  final ServiceDescription description;

  const ServicePage({
    Key? key,
    required this.service,
    required this.description,
  }) : super(key: key);

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
      body: description.actionList.actions.isEmpty
          ? NothingHere()
          : _Actions(
              actions: description.actionList.actions,
              serviceStateTable: description.serviceStateTable),
    );
  }
}

class _Actions extends StatelessWidget {
  final List<upnp.Action> actions;
  final ServiceStateTable serviceStateTable;
  final unlocked = true;

  const _Actions({
    Key? key,
    required this.actions,
    required this.serviceStateTable,
  }) : super(key: key);

  Widget _icon(BuildContext context) {
    return Icon(unlocked ? Icons.chevron_right : Icons.lock_outline);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...actions.map(
          (x) => ListTile(
            title: Text(x.name),
            trailing: _icon(context),
            onTap: () => Application.router!.navigateTo(
              context,
              Routes.action,
              routeSettings: RouteSettings(
                arguments: [
                  x,
                  serviceStateTable,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NothingHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.primaryColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.question_mark_rounded,
                size: 32,
                color: theme.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text('There\'s nothing here.')
        ],
      ),
    );
  }
}
