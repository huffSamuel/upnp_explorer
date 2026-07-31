import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalUrlField extends StatelessWidget {
  final String label;
  final String modelName;
  final Uri? modelUrl;
  final EdgeInsets? padding;

  const ExternalUrlField({
    super.key,
    required this.modelName,
    this.modelUrl,
    this.padding,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        GestureDetector(
          onTap: () {
            if (modelUrl == null) {
              return;
            }

            launchUrl(modelUrl!);
          },
          child: Row(
            children: [
              Text(
                modelName,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (modelUrl != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.open_in_new,
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withAlpha((.6 * 255).toInt()),
                    size: 20,
                  ),
                )
            ],
          ),
        ),
      ]),
    );
  }
}
