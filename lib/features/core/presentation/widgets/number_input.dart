import 'package:flutter/material.dart';

import '../../../../application/validators.dart';

class NumberInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  const NumberInput({super.key, required this.controller, this.focusNode});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      onTapOutside: (_) => _focusNode.unfocus(),
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      validator: Validators.isInteger,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
    );
  }
}
