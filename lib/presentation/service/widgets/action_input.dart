import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../application/data_type_config.dart';
import '../../../application/validators.dart';
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

class ArgumentInputFormState extends State<ArgumentInputForm> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, String?> _formValue;

  String? _argumentDefaultValue(Argument arg) {
    final relatedStateVariable = widget.stateTable.stateVariables.singleWhere(
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

    return DataTypeConfig
        .values[relatedStateVariable.dataType.type]?.defaultValue;
  }

  @override
  void initState() {
    super.initState();

    _formValue = Map<String, String?>.fromIterable(
      widget.inputs,
      key: (x) => x.name,
      value: (x) => _argumentDefaultValue(x as Argument),
    );
  }

  Map<String, String?>? validate() {
    if (_formKey.currentState?.validate() == false) {
      print('Invalid');
      return null;
    }

    return _formValue;
  }

  void _onInputChanged(String name, String? value) {
    setState(() {
      _formValue[name] = value;
    });
  }

  Widget _mapInputToWidget(Argument arg) {
    return ArgumentInput(
      argument: arg,
      value: _formValue[arg.name],
      onChanged: (v) => _onInputChanged(arg.name, v),
      stateVariable: widget.stateTable.stateVariables.firstWhere(
        (element) => element.name == arg.relatedStateVariable,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Input', style: theme.headline6),
            ...widget.inputs.map(_mapInputToWidget),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
          ],
        ),
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
    return Semantics(
      label: '$name ${value ?? "unknown"}',
      child: _OneThird(
        title: ExcludeSemantics(
          child: Text(
            name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        child: ExcludeSemantics(
          child: TextField(
            controller: TextEditingController(
              text: LineSplitter().convert(value ?? '').join(''),
            ),
            readOnly: true,
            maxLines: 1,
          ),
        ),
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

    if (stateVariable?.dataType.type == DataType.boolean) {
      return _SwitchInput(
        value: value == (true.toString()),
        onChanged: onChanged,
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

class _SwitchInput extends StatelessWidget {
  final bool value;
  final void Function(String?) onChanged;

  const _SwitchInput({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  void _onChanged(bool? value) {
    onChanged((value ?? false).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: _onChanged,
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

  String get _label => value.toInt().toString();

  void _onChangeEnd(double v) {
    widget.onChanged(v.toInt().toString());
  }

  void _onChanged(double v) {
    setState(() {
      value = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChangeEnd: _onChangeEnd,
      onChanged: _onChanged,
      label: _label,
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

class _TextVariableInput extends StatefulWidget {
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
  State<_TextVariableInput> createState() => _TextVariableInputState();
}

class _TextVariableInputState extends State<_TextVariableInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _controller.text = widget.value ?? '';

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _submit(_controller.text);
      }
    });

    super.initState();
  }

  void _submit(String value) {
    widget.onChanged(value);
  }

  DataTypeConfig? get _config =>
      DataTypeConfig.values[widget.stateVariable?.dataType.type];

  TextInputType? get _keyboardType => _config?.inputType ?? TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: TextFormField(
        validator: Validators.isNotEmpty,
        keyboardType: _keyboardType,
        onFieldSubmitted: _submit,
        onChanged: (s) => _controller.text = s,
        controller: TextEditingController(
          text: widget.value,
        ),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
