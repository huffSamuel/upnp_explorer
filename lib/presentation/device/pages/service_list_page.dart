import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/application.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/device/service_repository_type.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../service/bloc/command_bloc.dart';

class ServiceListPage extends StatelessWidget {
  final ServiceList services;
  final ServiceRepositoryType repo =
      sl<ServiceRepositoryType>(instanceName: 'ServiceRepository');

  ServiceListPage({
    Key? key,
    required this.services,
  }) : super(key: key);

  VoidCallback? _navigateToService(BuildContext context, Service service) {
    if (!repo.has(service.serviceId.toString())) {
      return null;
    }

    return () {
      BlocProvider.of<CommandBloc>(context).add(SetService(service));
      Application.router!.navigateTo(
        context,
        Routes.service(service.serviceId.toString()),
        routeSettings: RouteSettings(arguments: service),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.services),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: services.services.length,
          itemBuilder: (context, index) {
            final service = services.services[index];
            final onTap = _navigateToService(context, service);

            return ListTile(
              title: Text(service.serviceId.serviceId),
              trailing: onTap == null ? null : Icon(Icons.chevron_right),
              subtitle:
                  onTap == null ? Text(i18n.unableToObtainInformation) : null,
              onTap: onTap,
            );
          },
        ),
      ),
    );
  }
}
