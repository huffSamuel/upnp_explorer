import 'package:fl_upnp/fl_upnp.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/action_input.dart';
import '../widgets/action_output.dart';
import '../widgets/send_command_button.dart';

class ActionPage extends StatefulWidget {
  final ServiceAction action;
  final ServiceStateTable stateTable;

  const ActionPage({
    Key? key,
    required this.action,
    required this.stateTable,
  }) : super(key: key);

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  Map<String, String> _results = {};

  List<Argument> _inputs() => [
        ...?widget.action.arguments?.where((x) => x.direction == 'in'),
      ];

  List<Argument> _outputs() => [
        ...?widget.action.arguments?.where((x) => x.direction == 'out'),
      ];

  final _formKey = GlobalKey<ArgumentInputFormState>();

  Future<void> _send(BuildContext context) async {
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

    try {
      final result = await widget.action.invoke(ControlPoint.getInstance(), formValue);

      setState(() {
        _results = result.arguments;
      });
    } on ActionInvocationException catch (e) {
      _onCommandError(context, e.code, e.description);
    }
  }

  void _onCommandError(BuildContext context, String code, String message) {
    final snackbar = SnackBar(
      content: Text(AppLocalizations.of(context)!
          .commandFailedWithError('$code: $message')),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final sendButton = Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SendCommandButton(
          name: widget.action.name,
          onPressed: () => _send(context),
        ),
      ),
    );

    final children = [
      if (widget.action.arguments != null)
        if (_inputs().isNotEmpty)
          ArgumentInputForm(
            key: _formKey,
            inputs: _inputs(),
            stateTable: widget.stateTable,
          ),
      if (_outputs().isNotEmpty)
        ActionOutput(
          outputs: _outputs(),
          values: _results,
        ),
    ];

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
                  ),
                  title: FittedBox(
                    child: Text(widget.action.name),
                  ),
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
}
