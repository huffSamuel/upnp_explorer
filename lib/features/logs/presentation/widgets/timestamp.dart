import 'package:flutter/material.dart';

import '../../../../extension/build_context.dart';

class Timestamp extends StatelessWidget {
  final DateTime time;

  const Timestamp({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(4),
      child: Text(
        i18n.timestampValue(time),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hintColor,
            letterSpacing: -.3),
      ),
    );
  }
}
