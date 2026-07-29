import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final Icon icon;
  final Widget title;

  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconTheme(
          data: theme.iconTheme.copyWith(
            color: theme.colorScheme.primary,
            size: 20,
          ),
          child: icon,
        ),
        const SizedBox(width: 12),
        DefaultTextStyle(
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: -.3,
              color: theme.colorScheme.primary,
            ),
            child: title),
      ],
    );
  }
}
