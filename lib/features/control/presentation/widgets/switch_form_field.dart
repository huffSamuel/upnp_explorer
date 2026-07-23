import 'package:flutter/material.dart';

class CheckboxFormField extends StatefulWidget {
  final void Function(String? newValue) onSaved;

  const CheckboxFormField({super.key, required this.onSaved});

  @override
  State<CheckboxFormField> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      onSaved: (v) => widget.onSaved(switch (v) {
        true => 'true',
        false => 'false',
        _ => '',
      }),
      builder: (state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
              child: Switch(
                value: _value ?? false,
                onChanged: (v) {
                  state.didChange(v);
                  setState(() {
                    _value = v;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
