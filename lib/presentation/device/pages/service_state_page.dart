import 'package:fl_upnp/fl_upnp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/page/app_page.dart';

class ServiceStateTablePage extends StatelessWidget {
  final ServiceStateTable table;

  const ServiceStateTablePage({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

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
