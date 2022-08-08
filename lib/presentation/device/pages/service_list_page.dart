import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/device.dart';
import '../../core/widgets/download_list_tile.dart';

class ServiceListPage extends StatelessWidget {
  final ServiceList services;

  const ServiceListPage({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: services.services.length,
          itemBuilder: (context, index) {
            final service = services.services[index];

            return ListTile(
              title: Text(service.serviceId.serviceId),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Application.router!.navigateTo(
                context,
                Routes.service(
                  service.serviceId.toString(),
                ),
                routeSettings: RouteSettings(
                  arguments: service,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
