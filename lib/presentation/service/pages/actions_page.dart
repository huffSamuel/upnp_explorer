import 'package:flutter/material.dart';

import '../../../infrastructure/upnp/service_description.dart';

class ActionsPage extends StatelessWidget {
  final ActionList actionList;

  const ActionsPage({
    Key? key,
    required this.actionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions'),
      ),
      body: Column(
        children: actionList.actions
            .map(
              (x) => ListTile(
                title: Text(x.name),
                trailing: Icon(Icons.chevron_right),
              ),
            )
            .toList(),
      ),
    );
  }
}
