import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  final Widget label;
  final Widget child;

  const MyField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 12,
            color: theme.hintColor,
            fontWeight: FontWeight.w500,
          ),
          child: label,
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

class Label extends StatelessWidget {
  final Widget label;
  final TextStyle? style;

  const Label({super.key, required this.label, this.style});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 12,
        color: theme.hintColor,
        fontWeight: FontWeight.w500,
      ).merge(style),
      child: label,
    );
  }
}
