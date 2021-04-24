import 'package:flutter/material.dart';

import '../../../data/options.dart';
import '../../../domain/value_converter.dart';
import '../../../generated/l10n.dart';

void showVisualDensityDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return VisualDensityDialog();
    },
  );
}

class VisualDensityDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    final currentValue = kVisualDensityConverter.from(options.visualDensity);

    final density = Density.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: currentValue,
            onChanged: (v) {
              Options.update(
                context,
                options.copyWith(visualDensity: kVisualDensityConverter.to(v)),
              );
            },
            title: Text(i18n.visualDensity(value)),
          ),
        )
        .toList();

    final children = [
      ...density,
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            right: 16.0,
          ),
          child: TextButton(
            child: Text(i18n.ok),
            onPressed: Navigator.of(context).pop,
          ),
        ),
      ),
    ];

    return SimpleDialog(
      title: Text(i18n.density),
      children: children,
    );
  }
}
