import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:string_validator/string_validator.dart';
import 'package:upnp_explorer/packages/upnp/upnp.dart';

import '../../../application/validators.dart';
import 'labeled_field.dart';

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
    final StateVariable relatedStateVariable =
        widget.stateTable.stateVariables.singleWhere(
      (v) => v.name == arg.relatedStateVariable,
    );

    if (relatedStateVariable.defaultValue != null) {
      return relatedStateVariable.defaultValue;
    }

    if (relatedStateVariable.allowedValues?.isNotEmpty == true) {
      return relatedStateVariable.allowedValues!.first;
    }

    if (relatedStateVariable.allowedValueRange?.minimum != null) {
      return relatedStateVariable.allowedValueRange!.minimum;
    }

    return relatedStateVariable.dataType.defaultValue;
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
    final stateVariable = widget.stateTable.stateVariables.firstWhere(
      (element) => element.name == arg.relatedStateVariable,
    );
    return ArgumentInput(
      argument: arg,
      value: _formValue[arg.name],
      onChanged: (v) => _onInputChanged(arg.name, v),
      stateVariable: stateVariable,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final i18n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              i18n.input,
              style: theme.titleLarge,
            ),
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
    if (stateVariable?.allowedValues?.isNotEmpty ?? false) {
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

    if (stateVariable?.dataType.type == DataTypeValue.boolean) {
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
    return LabeledField(
      title: Text(
        argument.name,
        style: Theme.of(context).textTheme.titleMedium,
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
    div = (max - min) ~/ widget.stateVariable!.allowedValueRange!.step;
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
      stateVariable!.allowedValues!.map(
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
  late final DataTypeConfig _config;

  @override
  void initState() {
    _config = DataTypeConfig.values[widget.stateVariable?.dataType.type]!;

    if(widget.value != null) {
      print('Value ${widget.value}');
      _controller.text = widget.value!;
    }

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

  TextInputType? get _keyboardType => _config.inputType ?? TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: TextFormField(
        validator: Validators.isNotEmpty,
        keyboardType: _keyboardType,
        onFieldSubmitted: _submit,
        onChanged: (s) => _controller.text = s,
        controller: _controller,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}

class DataTypeConfig {
  final String? Function(String?)? validator;
  final TextInputType? inputType;

  DataTypeConfig(
    this.validator,
    this.inputType,
  );

  static Map<DataTypeValue?, DataTypeConfig> values = Map.fromIterable(
    DataTypeValue.values,
    key: (e) => e as DataTypeValue,
    value: (e) => fromDataType(e),
  );

  static DataTypeConfig fromDataType(DataTypeValue type) {
    return DataTypeConfig(
      _validator(type),
      _inputType(type),
    );
  }
}

TextInputType? _inputType(DataTypeValue type) {
  switch (type) {
    case DataTypeValue.ui1:
    case DataTypeValue.ui2:
    case DataTypeValue.ui4:
    case DataTypeValue.ui8:
      return TextInputType.number;
    case DataTypeValue.i1:
    case DataTypeValue.i2:
    case DataTypeValue.i4:
    case DataTypeValue.i8:
    case DataTypeValue.int:
      return TextInputType.numberWithOptions(
        signed: true,
      );
    case DataTypeValue.r4:
    case DataTypeValue.r8:
    case DataTypeValue.number:
    case DataTypeValue.fixed14_4:
    case DataTypeValue.float:
      return TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      );
    case DataTypeValue.date:
    case DataTypeValue.dateTime:
    case DataTypeValue.dateTimeTz:
    case DataTypeValue.time:
    case DataTypeValue.timeTz:
      return TextInputType.datetime;
    case DataTypeValue.uri:
      return TextInputType.url;
    default:
      return null;
  }
}

String? Function(String?)? _validator(DataTypeValue dataType) {
  switch (dataType) {
    case DataTypeValue.char:
      return (s) => s == null || s.length != 1 ? '*' : null;
    case DataTypeValue.binaryBase64:
      return (s) => s == null || !isBase64(s) ? '*' : null;
    case DataTypeValue.binaryHex:
      return (s) => s == null || !isHexadecimal(s) ? '*' : null;
    case DataTypeValue.uri:
      return (s) => s == null || Uri.tryParse(s) == null ? '*' : null;
    // TODO: Split out individually for each specific format
    case DataTypeValue.date:
    case DataTypeValue.dateTime:
    case DataTypeValue.dateTimeTz:
    case DataTypeValue.time:
    case DataTypeValue.timeTz:
      return (s) => s == null || DateTime.tryParse(s) == null ? '*' : null;
    case DataTypeValue.boolean:
      return (s) => s == null || !['true', 'false'].contains(s) ? '*' : null;
    case DataTypeValue.uuid:
      return (s) => s == null || !isUUID(s) ? '*' : null;
    // TODO: numerical constraints
    default:
      return (s) => s == null || s.length == 0 ? '*' : null;
  }
}
