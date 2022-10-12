import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../infrastructure/upnp/models/service_description.dart' as upnp;

class ActionPage extends StatelessWidget {
  final upnp.Action action;

  const ActionPage({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(action.name),
      ),
      body: Center(
        child: Text(i18n.controlUnavailable),
      ),
    );
  }
}
