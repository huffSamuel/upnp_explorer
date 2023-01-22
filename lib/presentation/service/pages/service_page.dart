import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../../core/page/app_page.dart';

class ServicePage extends StatelessWidget {
  final Service service;
  final ServiceDescription description;
  final unlocked = true;

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
    final actions = [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
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
    ];

    final children = description.actionList.actions.isEmpty
        ? [NothingHere()]
        : List<Widget>.of(
            description.actionList.actions.map(
              (x) {
                return ListTile(
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
                );
              },
            ),
          );

    return AppPage(
      title: Text(service.serviceId.serviceId),
      children: children,
      actions: actions,
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
          const SizedBox(height: 32.0),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.onBackground,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.question_mark_rounded,
                size: 32,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
          SizedBox(height: 32.0),
          Text('There\'s nothing here.')
        ],
      ),
    );
  }
}
