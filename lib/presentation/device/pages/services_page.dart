import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/routing/routes.dart';
import '../../../simple_upnp/src/upnp.dart';
import '../../service/pages/service_page.dart';

class ServicesPage extends StatelessWidget {
  final DeviceAggregate device;

  const ServicesPage({
    super.key,
    required this.device,
  });

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
    List<Widget> body;

    if (device.services.isEmpty) {
      body = [
        Center(child: Text(i18n.nothingHere)),
      ];
    } else {
      body = List.from(
        device.services.map(
          (service) {
            final onTap = service.service == null
                ? null
                : _navigateToService(context, service);

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
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ),
    );
  }
}
