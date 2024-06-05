import 'package:flutter/material.dart';

class AboutTile extends StatelessWidget {
  final Widget child;

  const AboutTile({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: const SizedBox(height: 12.0),
      subtitle: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22.0),
            Icon(
              Icons.info_outline_rounded,
              color: theme.colorScheme.onSurface,
            ),
            const SizedBox(height: 22.0),
            child,
          ],
        ),
      ),
    );
  }
}
