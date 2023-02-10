import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/ioc.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/device/service_repository_type.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../core/page/app_page.dart';
import '../../service/bloc/command_bloc.dart';
import '../../service/pages/service_page.dart';

class ServiceListPage extends StatelessWidget {
  final String deviceId;
  final List<Service> services;
  final ServiceDescriptionRepository repo = sl<ServiceDescriptionRepository>();

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

      final description = sl.get<ServiceDescriptionRepository>().get(
            deviceId,
            service.serviceId.toString(),
          )!;

      Navigator.of(context).push(
        makeRoute(
          context,
          ServicePage(service: service, description: description),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    final children = List<Widget>.from(
      services.map(
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
