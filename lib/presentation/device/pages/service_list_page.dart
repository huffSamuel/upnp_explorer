import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upnp_explorer/presentation/core/page/app_page.dart';

import '../../../application/application.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/routing/route_arguments.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/device/service_repository_type.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../service/bloc/command_bloc.dart';

class ServiceListPage extends StatelessWidget {
  final String deviceId;
  final ServiceList services;
  final ServiceDescriptionRepository repo =
      sl<ServiceDescriptionRepository>();

  ServiceListPage({
    Key? key,
    required this.services,
    required this.deviceId,
  }) : super(key: key);

  VoidCallback? _navigateToService(BuildContext context, Service service) {
    if (!repo.has(deviceId, service.serviceId.toString())) {
      return null;
    }

    return () {
      BlocProvider.of<CommandBloc>(context).add(SetService(service));
      Application.router!.navigateTo(
        context,
        Routes.service(service.serviceId.toString()),
        routeSettings: RouteSettings(
          arguments: ServicePageRouteArgs(
            service,
            deviceId,
          ),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    final children = List<Widget>.from(
      services.services.map(
        (service) {
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
    );

    return AppPage(
      title: Text(i18n.services),
      children: children,
    );
  }
}
