import 'package:flutter/material.dart';

import '../../../../extension/build_context.dart';
import '../../../core/presentation/widgets/my_card.dart';
import 'action_outputs_card.dart';
import 'action_result.dart';
import 'command_status_field.dart';
import 'my_field.dart';

class DeviceResponseCard extends StatelessWidget {
  final ActionResult result;

  const DeviceResponseCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return MyCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                i18n.status,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -.3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            i18n.status.toUpperCase(),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 12,
              color: theme.hintColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          CommandStatusField(status: result.status),
          const SizedBox(height: 8),
          MyField(
            label: Text(i18n.latency.toUpperCase()),
            child: OutputTextField(
              value: result.duration == null
                  ? null
                  : i18n.ms(result.duration!.inMilliseconds),
            ),
          ),
          if (result.status == CommandStatus.error)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                MyField(
                  label: Text(i18n.statusMessage.toUpperCase()),
                  child: OutputTextField(value: result.errorMessage),
                ),
              ],
            )
        ],
      ),
    );
  }
}
