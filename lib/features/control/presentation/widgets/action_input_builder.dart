import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import 'number_picker_form_field.dart';
import 'switch_form_field.dart';

class ActionInputBuilder extends StatelessWidget {
  final void Function(String, String?) onSaved;
  final Argument argument;
  final StateVariable? stateVariable;

  const ActionInputBuilder({
    super.key,
    required this.argument,
    this.stateVariable,
    required this.onSaved,
  });

  void _onSaved(String? value) {
    onSaved(argument.name, value);
  }

  @override
  Widget build(BuildContext context) {
    if (stateVariable?.allowedValues?.isNotEmpty == true) {
      return DropdownButtonFormField(
        onSaved: _onSaved,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        initialValue: stateVariable!.allowedValues!.length == 1
            ? stateVariable!.allowedValues!.first
            : null,
        items: [
          ...stateVariable!.allowedValues!
              .map((v) => DropdownMenuItem(value: v, child: Text(v))),
        ],
        onChanged: (_) {},
      );
    }

    if (stateVariable?.allowedValueRange != null) {
      return VariableNumberPickerFormField(
        onSaved: _onSaved,
        stateVariable: stateVariable!,
      );
    }

    if (stateVariable?.dataType.type == DataTypeValue.boolean) {
      return CheckboxFormField(
        onSaved: _onSaved,
      );
    }

    return TextFormField(
      onSaved: _onSaved,
      initialValue: stateVariable?.defaultValue,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
    );
  }
}
