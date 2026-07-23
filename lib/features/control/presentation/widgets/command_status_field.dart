import 'package:flutter/material.dart';
import '../../../core/light.dart';

enum CommandStatus {
  notExecuted,
  success,
  error,
}

class CommandStatusField extends StatelessWidget {
  final CommandStatus status;

  const CommandStatusField({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: switch (status) {
              CommandStatus.success =>
                theme.extension<MyCustomColors>()?.brandSuccess ?? Colors.green,
              CommandStatus.error => theme.colorScheme.error,
              _ => theme.dividerColor
            },
          ),
        ),
        const SizedBox(width: 8),
        DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: 16,
              color: switch (status) {
                CommandStatus.notExecuted => theme.dividerColor,
                CommandStatus.error => theme.colorScheme.error,
                _ => null,
              },
              fontWeight:
                  status == CommandStatus.error ? FontWeight.w600 : null,
            ),
            child: switch (status) {
              CommandStatus.success => Text('Success'),
              CommandStatus.error => Text('Failed'),
              _ => Text('Not Executed'),
            }),
      ],
    );
  }
}
