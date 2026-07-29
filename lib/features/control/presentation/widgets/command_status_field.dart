import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';
import 'package:upnp_explorer/features/core/custom_colors.dart';

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
    final i18n = context.i18n();

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
            fontWeight: status == CommandStatus.error ? FontWeight.w600 : null,
          ),
          child: switch (status) {
            CommandStatus.success => Text(i18n.success),
            CommandStatus.error => Text(i18n.failed),
            _ => Text(i18n.notExecuted),
          },
        ),
      ],
    );
  }
}
