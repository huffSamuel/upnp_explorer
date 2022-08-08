import 'package:flutter/material.dart';
import 'package:upnp_explorer/infrastructure/upnp/service_description.dart';

import '../../../infrastructure/upnp/device.dart';

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
      ),
    );
  }
}
