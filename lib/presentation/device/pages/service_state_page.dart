import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../infrastructure/upnp/models/service_description.dart';

class ServiceStateTablePage extends StatelessWidget {
  final ServiceStateTable table;

  const ServiceStateTablePage({Key? key, required this.table})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(i18n.stateVariables)),
      body: ListView.builder(
        itemCount: table.stateVariables.length,
        itemBuilder: (context, index) {
          final item = table.stateVariables[index];

          return ListTile(
            title: Text(item.name),
          );
        },
      ),
    );
  }
}
