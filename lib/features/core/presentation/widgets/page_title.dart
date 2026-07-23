import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final Widget child;

  const PageTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return DefaultTextStyle.merge(
      style: TextStyle(
        color: primary,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      child: IconTheme.merge(
          data: IconThemeData(
            color: primary,
            size: 20,
          ),
          child: child),
    );
  }
}
