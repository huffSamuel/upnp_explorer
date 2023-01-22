import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../../core/page/app_page.dart';

class ServiceStateTablePage extends StatelessWidget {
  final ServiceStateTable table;

  const ServiceStateTablePage({Key? key, required this.table})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    final children = List<Widget>.from(
      table.stateVariables.map(
        (x) => ListTile(
          title: Text(x.name),
        ),
      ),
    );

    return AppPage(
      title: Text(i18n.stateVariables),
      children: children,
    );
  }
}
