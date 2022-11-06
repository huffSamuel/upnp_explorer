import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/upnp/models/service_description.dart';
import '../bloc/command_bloc.dart';
import 'action_input.dart';

class ActionOutput extends StatelessWidget {
  final List<Argument> outputs;

  const ActionOutput({
    Key? key,
    required this.outputs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CommandBloc, CommandState>(
        buildWhen: (oldState, newState) => newState is ActionSuccess,
        builder: (context, state) {
          Map<String, String?> outputValues = {};
          if (state is ActionSuccess) {
            state.data.forEach((x) => outputValues[x.name] = x.value);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Output', style: theme.headline6),
              ...outputs.map(
                (x) => ArgumentOutput(
                  name: x.name,
                  value: outputValues[x.name],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
