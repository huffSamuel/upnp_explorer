import 'package:flutter/material.dart';
import '../../../../application/validators.dart';
import 'package:upnped/upnped.dart';

class VariableNumberPickerFormField extends StatefulWidget {
  final StateVariable stateVariable;
  final void Function(String? newValue) onSaved;

  const VariableNumberPickerFormField({super.key, required this.stateVariable, required this.onSaved});

  @override
  State<VariableNumberPickerFormField> createState() => _VariableNumberPickerFormFieldState();
}

class _VariableNumberPickerFormFieldState extends State<VariableNumberPickerFormField> {
  late num _value;
  late final TextEditingController _controller;

  @override
  void initState() {
    _value = _initialValue();
    _controller = TextEditingController(text: _value.toString());

    super.initState();
  }

  num _initialValue() {
    if (widget.stateVariable.defaultValue != null) {
      final v = num.tryParse(widget.stateVariable.defaultValue!);

      if (v != null) {
        return v;
      }
    }

    final range = widget.stateVariable.allowedValueRange!;

    return num.parse(range.minimum);
  }

  bool _canIncrement() {
    return _value < num.parse(widget.stateVariable.allowedValueRange!.maximum);
  }

  bool _canDecrement() {
    return _value > num.parse(widget.stateVariable.allowedValueRange!.minimum);
  }

  void _increment() {
    set(_value + widget.stateVariable.allowedValueRange!.step);
  }

  void decrement() {
    set(_value - widget.stateVariable.allowedValueRange!.step);
  }

  void set(num value) {
    setState(() {
      _value = value;
      _controller.text = _value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          onPressed: _canDecrement() ? decrement : null,
          icon: Icon(Icons.remove),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            validator: Validators.isInteger,
            onSaved: widget.onSaved,
            controller: _controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          onPressed: _canIncrement() ? _increment : null,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}