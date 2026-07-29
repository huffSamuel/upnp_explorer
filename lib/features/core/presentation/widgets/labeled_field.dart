import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final Widget label;
  final Widget? child;
  final EdgeInsets? padding;

  const LabeledField({
    super.key,
    required this.label,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (child == null) {
      return const SizedBox();
    }

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DefaultTextStyle(
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 12,
            color: theme.hintColor,
            fontWeight: FontWeight.w500,
          ),
          child: label,
        ),
        DefaultTextStyle(
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          child: child ?? const SizedBox(),
        ),
      ]),
    );
  }
}
