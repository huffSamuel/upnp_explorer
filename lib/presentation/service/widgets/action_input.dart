import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../infrastructure/upnp/models/service_description.dart';

class ArgumentInputForm extends StatefulWidget {
  final List<Argument> inputs;
  final ServiceStateTable stateTable;

  const ArgumentInputForm({
    Key? key,
    required this.inputs,
    required this.stateTable,
  }) : super(key: key);

  @override
  State<ArgumentInputForm> createState() => ArgumentInputFormState();
}

const _defaultValueMap = {
  DataType.ui1 : '0',
  DataType.ui2 : '0',
  DataType.ui4 : '0',
  DataType.ui8 : '0',
};

class ArgumentInputFormState extends State<ArgumentInputForm> {
  final _formKey = GlobalKey<FormState>();

  late Map<String, String?> _formValue;

  @override
  void initState() {
    super.initState();

    _formValue = Map<String, String?>.fromIterable(
      widget.inputs,
      key: (x) => x.name,
      value: (x) {
        final arg = x as Argument;
        final relatedStateVariable =
            widget.stateTable.stateVariables.singleWhere(
          (v) => v.name == arg.relatedStateVariable,
        );

        if (relatedStateVariable.defaultValue != null) {
          return relatedStateVariable.defaultValue;
        }

        if (relatedStateVariable.allowedValueList?.allowedValues.isNotEmpty ==
            true) {
          return relatedStateVariable.allowedValueList!.allowedValues.first;
        }

        if (relatedStateVariable.allowedValueRange?.minimum != null) {
          return relatedStateVariable.allowedValueRange!.minimum;
        }

        return _defaultValueMap[relatedStateVariable.dataType.type];
      },
    );
  }

  Map<String, String?>? validate() {
    if (_formKey.currentState?.validate() == false) {
      print('Invalid');
      return null;
    }

    return _formValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Input', style: theme.headline6),
          ...widget.inputs.map(
            (x) => ArgumentInput(
              argument: x,
              value: _formValue[x.name],
              onChanged: (v) {
                setState(() {
                  print('set ${x.name}: $v');
                  _formValue[x.name] = v;
                });
              },
              stateVariable: widget.stateTable.stateVariables.firstWhere(
                (element) => element.name == x.relatedStateVariable,
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

class _OneThird extends StatelessWidget {
  final Widget title;
  final Widget child;

  const _OneThird({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6.0),
        title,
        const SizedBox(height: 4.0),
        child,
      ],
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

  @override
  Widget build(BuildContext context) {
    return _OneThird(
      title: Text(
        name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      child: TextField(
        controller: TextEditingController(
          text: LineSplitter().convert(value ?? '').join(''),
        ),
        readOnly: true,
        maxLines: 1,
      ),
    );
  }
}

class ArgumentInput extends StatelessWidget {
  final Argument argument;
  final StateVariable? stateVariable;
  final String? value;
  final void Function(String?) onChanged;

  const ArgumentInput({
    Key? key,
    required this.argument,
    required this.stateVariable,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  Widget _input(BuildContext context) {
    if (stateVariable?.allowedValueList?.allowedValues.isNotEmpty ?? false) {
      return _AllowedListInput(
        value: value,
        argument: argument,
        stateVariable: stateVariable,
        onChanged: onChanged,
      );
    }

    if (stateVariable?.allowedValueRange != null) {
      return _AllowedRangeInput(
        value: value,
        onChanged: onChanged,
        argument: argument,
        stateVariable: stateVariable,
      );
    }

    return _TextVariableInput(
      value: value,
      onChanged: onChanged,
      argument: argument,
      stateVariable: stateVariable,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _OneThird(
      title: Text(
        argument.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      child: _input(context),
    );
  }
}

class _AllowedRangeInput extends StatefulWidget {
  final Argument argument;
  final StateVariable? stateVariable;
  final String? value;
  final void Function(String?) onChanged;

  const _AllowedRangeInput({
    Key? key,
    required this.argument,
    required this.onChanged,
    this.value,
    this.stateVariable,
  }) : super(key: key);

  @override
  State<_AllowedRangeInput> createState() => _AllowedRangeInputState();
}

class _AllowedRangeInputState extends State<_AllowedRangeInput> {
  late double value;
  late double min;
  late double max;
  late int div;

  @override
  void initState() {
    value = double.parse(widget.value ?? '0');
    min = double.parse(widget.stateVariable!.allowedValueRange!.minimum);
    max = double.parse(widget.stateVariable!.allowedValueRange!.maximum);
    div = (max - min) ~/
        int.parse(widget.stateVariable!.allowedValueRange!.step ?? '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChangeEnd: (v) {
        widget.onChanged(v.toInt().toString());
      },
      onChanged: (v) {
        setState(() {
          value = v;
        });
      },
      label: value.toInt().toString(),
      min: min,
      max: max,
      divisions: div,
    );
  }
}

class _AllowedListInput extends StatelessWidget {
  final Argument argument;
  final StateVariable? stateVariable;
  final String? value;
  final void Function(String?) onChanged;

  const _AllowedListInput({
    Key? key,
    required this.argument,
    this.stateVariable,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  List<DropdownMenuItem<String>> _buildItems() {
    return List.from(
      stateVariable!.allowedValueList!.allowedValues.map(
        (x) => DropdownMenuItem(
          value: x,
          child: Text(x),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      value: value,
      onChanged: onChanged,
      items: _buildItems(),
    );
  }
}

class _TextVariableInput extends StatelessWidget {
  final Argument argument;
  final StateVariable? stateVariable;
  final void Function(String?) onChanged;
  final String? value;

  const _TextVariableInput({
    Key? key,
    required this.argument,
    required this.stateVariable,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (s) {
        if (s == null || s.isEmpty) {
          return '*';
        }

        return null;
      },
      onChanged: onChanged,
      controller: TextEditingController(
        text: value,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
      ),
    );
  }
}
