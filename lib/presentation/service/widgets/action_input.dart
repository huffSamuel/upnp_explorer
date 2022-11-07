import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../application/validators.dart';
import '../../../infrastructure/upnp/models/service_description.dart';
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
    final i18n = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              i18n.input,
              style: theme.headline6,
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
    return LabeledField(
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

class DataTypeConfig {
  final String? defaultValue;
  final String? Function(String?)? validator;
  final TextInputType? inputType;

  DataTypeConfig(
    this.defaultValue,
    this.validator,
    this.inputType,
  );

  static Map<DataType?, DataTypeConfig> values = Map.fromIterable(
    DataType.values,
    key: (e) => e as DataType,
    value: (e) => fromDataType(e),
  );

  static DataTypeConfig fromDataType(DataType type) {
    return DataTypeConfig(
      _defaultValue(type),
      _validator(type),
      _inputType(type),
    );
  }
}

TextInputType? _inputType(DataType type) {
  switch (type) {
    case DataType.ui1:
    case DataType.ui2:
    case DataType.ui4:
    case DataType.ui8:
      return TextInputType.number;
    case DataType.i1:
    case DataType.i2:
    case DataType.i4:
    case DataType.i8:
    case DataType.int:
      return TextInputType.numberWithOptions(
        signed: true,
      );
    case DataType.r4:
    case DataType.r8:
    case DataType.number:
    case DataType.fixed14_4:
    case DataType.float:
      return TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      );
    case DataType.date:
    case DataType.dateTime:
    case DataType.dateTimeTz:
    case DataType.time:
    case DataType.timeTz:
      return TextInputType.datetime;
    case DataType.uri:
      return TextInputType.url;
    default:
      return null;
  }
}

String? Function(String?)? _validator(DataType dataType) {
  switch (dataType) {
    case DataType.char:
      return (s) => s == null || s.length != 1 ? '*' : null;
    case DataType.binaryBase64:
      return (s) => s == null || !isBase64(s) ? '*' : null;
    case DataType.binaryHex:
      return (s) => s == null || !isHexadecimal(s) ? '*' : null;
    case DataType.uri:
      return (s) => s == null || Uri.tryParse(s) == null ? '*' : null;
    // TODO: Split out individually for each specific format
    case DataType.date:
    case DataType.dateTime:
    case DataType.dateTimeTz:
    case DataType.time:
    case DataType.timeTz:
      return (s) => s == null || DateTime.tryParse(s) == null ? '*' : null;
    case DataType.boolean:
      return (s) => s == null || !['true', 'false'].contains(s) ? '*' : null;
    case DataType.uuid:
      return (s) => s == null || !isUUID(s) ? '*' : null;
    // TODO: numerical constraints
    default:
      return (s) => s == null || s.length == 0 ? '*' : null;
  }
}

String? _defaultValue(DataType type) {
  switch (type) {
    case DataType.char:
    case DataType.string:
    case DataType.binaryBase64:
    case DataType.binaryHex:
    case DataType.uri:
      return null;
    case DataType.date:
      return '1985-04-12';
    case DataType.dateTime:
      return '1985-04-12T10:15:30';
    case DataType.dateTimeTz:
      return '1985-04-12T10:15:30+0400';
    case DataType.time:
      return '23:20:50';
    case DataType.timeTz:
      return '23:20:50+0100';
    case DataType.boolean:
      return 'true';
    case DataType.uuid:
      return '00000000-0000-0000-0000-000000000000';
    default:
      return '0';
  }
}
