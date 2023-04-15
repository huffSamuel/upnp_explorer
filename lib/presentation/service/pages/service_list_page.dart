import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/packages/upnp/upnp.dart';

import '../../../application/routing/routes.dart';
import '../../core/page/app_page.dart';
import 'service_page.dart';

class ServiceListPage extends StatelessWidget {
  final String deviceId;
  final List<ServiceAggregate> services;

  ServiceListPage({
    Key? key,
    required this.services,
    required this.deviceId,
  }) : super(key: key);

  VoidCallback? _navigateToService(
      BuildContext context, ServiceAggregate service) {
    return () {
      Navigator.of(context).push(
        makeRoute(
          context,
          ServicePage(service: service),
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
          final onTap =  service.service == null ? null : _navigateToService(context, service);

          return ListTile(
            title: Text(service.document.serviceId.serviceId),
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
