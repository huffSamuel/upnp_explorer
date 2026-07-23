import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:upnped/upnped.dart';

import '../../../core/presentation/widgets/page_title.dart';
import '../widgets/action_inputs_card.dart';
import '../widgets/action_outputs_card.dart';
import '../widgets/action_result.dart';
import '../widgets/command_status_field.dart';
import '../widgets/device_response_card.dart';
import '../widgets/execute_action_button.dart';

class ActionPage2 extends StatefulWidget {
  final Action action;
  final ServiceStateTable serviceStateTable;

  const ActionPage2({
    super.key,
    required this.action,
    required this.serviceStateTable,
  });

  @override
  State<ActionPage2> createState() => _ActionPage2State();
}

class _ActionPage2State extends State<ActionPage2> {
  final _inputsKey = GlobalKey<ActionInputsCardState>();

  ActionResult _result = ActionResult(
    status: CommandStatus.notExecuted,
    duration: null,
    results: null,
  );

  Future<void> _execute() async {
    Map<String, String?>? value;

    if (widget.action.inputs.isEmpty) {
      value = {};
    } else {
      value = _inputsKey.currentState?.validate();
    }

    if (value == null) {
      return;
    }

    await HapticFeedback.heavyImpact();

    final sw = Stopwatch()..start();

    try {
      final result = await widget.action.invoke(value);

      setState(() {
        _result = ActionResult(
          status: CommandStatus.success,
          duration: (sw..stop()).elapsed,
          results: result.arguments,
        );
      });
    } on ActionInvocationException catch (err) {
      setState(() {
        _result = ActionResult(
          status: CommandStatus.error,
          duration: (sw..stop()).elapsed,
          results: null,
          errorMessage: '${err.code}: ${err.description}',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          child: Text('Action'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.action.name,
                  style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -.3),
                ),
              )),
          const SizedBox(height: 16),
          if (widget.action.inputs.isNotEmpty)
            ActionInputsCard(
              key: _inputsKey,
              action: widget.action,
              serviceStateTable: widget.serviceStateTable,
            ),
          ExecuteActionButton(onPressed: _execute),
          DeviceResponseCard(result: _result),
          if (widget.action.outputs.isNotEmpty)
            ActionOutputsCard(action: widget.action, result: _result),
        ],
      ),
    );
  }
}
