import 'package:flutter/material.dart';

class InformationField extends StatelessWidget {
  final String label;
  final String? value;
  final EdgeInsets? padding;

  const InformationField({
    super.key,
    required this.label,
    this.value,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (value == null) {
      return const SizedBox();
    }

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 12,
            color: theme.hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value!,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}
