import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final Widget title;
  final Widget child;

  const LabeledField({
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
