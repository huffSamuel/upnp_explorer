import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
import '../bloc/command_bloc.dart';
import 'labeled_field.dart';

class ActionOutput extends StatelessWidget {
  final List<Argument> outputs;

  const ActionOutput({
    Key? key,
    required this.outputs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
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
              Text(
                i18n.output,
                style: theme.headline6,
              ),
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

class ArgumentOutput extends StatelessWidget {
  final String name;
  final String? value;

  const ArgumentOutput({
    Key? key,
    required this.name,
    this.value,
  }) : super(key: key);

  get text => LineSplitter().convert(value ?? '').join('');

  String label(BuildContext context) => value == null
      ? S.of(context).unknownValue(name)
      : S.of(context).knownValue(name, value!);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label(context),
      child: LabeledField(
        title: ExcludeSemantics(
          child: Text(
            name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        child: ExcludeSemantics(
          child: TextField(
            controller: TextEditingController(
              text: text,
            ),
            enabled: false,
            readOnly: true,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
