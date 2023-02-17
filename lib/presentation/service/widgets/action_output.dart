import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/presentation/service/widgets/action_output_dialog.dart';

import '../../../infrastructure/upnp/models/service_description.dart';
import '../../core/has_text_overflowed.dart';
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
    final i18n = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<CommandBloc, CommandState>(
        listener: (context, state) {
          if (state is ActionFault) {
            final snackbar = SnackBar(
              content: Text(i18n.commandFailedWithError(state.code)),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
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
                style: theme.titleLarge,
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
      ? AppLocalizations.of(context)!.unknownValue(name)
      : AppLocalizations.of(context)!.knownValue(name, value!);

  void _showFullText(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => ActionOutputDialog(
        text: text,
        propertyName: name,
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextStyle style) {
    final field = LabeledField(
      title: ExcludeSemantics(
        child: Text(
          name,
          style: style,
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
    );

    if (hasTextOverflowed(
      text,
      style,
      maxWidth: MediaQuery.of(context).size.width,
    )) {
      return GestureDetector(
        onTap: () => _showFullText(context),
        child: field,
      );
    }

    return field;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label(context),
      child: _buildTextField(
        context,
        Theme.of(context).textTheme.titleMedium!,
      ),
    );
  }
}
