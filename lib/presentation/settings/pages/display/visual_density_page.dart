import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/settings.dart';
import '../../../../domain/value_converter.dart';
import '../../widgets/settings_category_page.dart';

class VisualDensityPage extends StatelessWidget {
  const VisualDensityPage();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final options = Settings.of(context);

    final currentValue = kVisualDensityConverter.from(options.visualDensity);

    final density = Density.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: currentValue,
            onChanged: (Density? v) {
              if (v == null) {
                return;
              }

              Settings.update(
                context,
                options.copyWith(density: v),
              );
            },
            title: Text(i18n.visualDensity(value.name)),
          ),
        )
        .toList();

    return SettingsCategoryPage(
      category: i18n.density,
      children: density,
    );
  }
}
