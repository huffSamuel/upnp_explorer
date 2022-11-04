import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/upnp/models/service_description.dart' as upnp;
import '../../../infrastructure/upnp/models/service_description.dart';
import '../../device/bloc/device_bloc.dart';
import '../widgets/action_input.dart';
import '../widgets/action_output.dart';
import '../widgets/send_command_button.dart';

class ActionPage extends StatelessWidget {
  final upnp.Action action;
  final upnp.ServiceStateTable stateTable;

  ActionPage({
    Key? key,
    required this.action,
    required this.stateTable,
  }) : super(key: key);

  List<Argument> _inputs() => [
        ...?action.argumentList?.arguments.where((x) => x.direction == 'in'),
      ];

  List<Argument> _outputs() => [
        ...?action.argumentList?.arguments.where((x) => x.direction == 'out'),
      ];

  final _formKey = GlobalKey<ArgumentInputFormState>();

  void _send(BuildContext context) {
    final bloc = BlocProvider.of<DeviceBloc>(context);

    Map<String, String?>? formValue;

    if (_inputs().isEmpty) {
      formValue = {};
    } else {
      formValue = _formKey.currentState?.validate();
    }

    if (formValue == null) {
      return;
    }

    bloc.add(SendCommand(
      formValue,
      action.name,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(action.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(shrinkWrap: true, children: [
                if (action.argumentList != null)
                  if (_inputs().isNotEmpty)
                    ArgumentInputForm(
                      key: _formKey,
                      inputs: _inputs(),
                      stateTable: stateTable,
                    ),
                if (_outputs().isNotEmpty)
                  ActionOutput(
                    outputs: _outputs(),
                  ),
              ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SendCommandButton(
              onPressed: () => _send(context),
            ),
          ),
        ],
      ),
    );
  }
}
