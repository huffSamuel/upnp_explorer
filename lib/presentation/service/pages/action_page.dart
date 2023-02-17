import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/upnp/models/service_description.dart' as upnp;
import '../../../infrastructure/upnp/models/service_description.dart';
import '../bloc/command_bloc.dart';
import '../widgets/action_input.dart';
import '../widgets/action_output.dart';
import '../widgets/send_command_button.dart';

class ActionPage extends StatelessWidget {
  final _controller = ScrollController();
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
    final bloc = BlocProvider.of<CommandBloc>(context);

    Map<String, String?>? formValue;

    if (_inputs().isEmpty) {
      formValue = {};
    } else {
      formValue = _formKey.currentState?.validate();
    }

    if (formValue == null) {
      return;
    }

    HapticFeedback.heavyImpact();

    bloc.add(SendCommand(
      formValue,
      action.name,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final sendButton = Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SendCommandButton(
          name: action.name,
          onPressed: () => _send(context),
        ),
      ),
    );

    final children = [
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
    ];

    if (theme.useMaterial3) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 86.0,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                      color: theme.colorScheme.onPrimary,
                    ),
                    title: FittedBox(
                      child: DefaultTextStyle.merge(
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                        child: Text(action.name),
                      ),
                    ),
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => index < children.length
                          ? children[index]
                          : SizedBox(height: 86),
                      childCount: children.length + 1,
                    ),
                  )
                ],
              ),
            ),
            sendButton,
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(action.name),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              controller: _controller,
              child: ListView(
                controller: _controller,
                shrinkWrap: true,
                children: [
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
                ],
              ),
            ),
          ),
          sendButton,
        ],
      ),
    );
  }
}
