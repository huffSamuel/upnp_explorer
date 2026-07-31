import 'package:flutter/material.dart';

import '../../../../extension/build_context.dart';
import '../../../core/custom_colors.dart';

class StatusChip extends StatelessWidget {
  final int statusCode;
  final String? reasonPhrase;

  const StatusChip({super.key, required this.statusCode, this.reasonPhrase});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();
    final extension = theme.extension<MyCustomColors>()!;

    Color? background;
    Color? foreground;

    if (statusCode >= 200 && statusCode <= 299) {
      background = extension.brandSuccess;
      foreground = extension.onSuccess;
    } else if (statusCode >= 400 && statusCode <= 599) {
      background = theme.colorScheme.errorContainer;
      foreground = theme.colorScheme.error;
    }

    return Chip(
      color: WidgetStatePropertyAll(background),
      shape: StadiumBorder(
          side: BorderSide(color: background ?? const Color(0xFF000000))),
      label: Row(
        children: [
          if (statusCode >= 200 && statusCode <= 299)
            Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.check_circle_outline,
                    color: foreground, size: 16)),
          Text(i18n.codeAndReason(statusCode, reasonPhrase ?? i18n.unknown)),
        ],
      ),
      labelStyle: TextStyle(color: foreground),
    );
  }
}
