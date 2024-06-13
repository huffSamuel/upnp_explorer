import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/settings.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings_category_page.dart';
import '../../widgets/settings_category_tile.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final options = Settings.of(context);

    final themes = ThemeMode.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: options.themeMode,
            onChanged: (ThemeMode? v) {
              if (v == null) {
                return;
              }

              Settings.update(
                context,
                options.copyWith(themeMode: v),
              );
            },
            title: Text(i18n.themeMode(value.name)),
          ),
        )
        .toList();

    return SettingsCategoryPage(
      category: i18n.theme,
      children: [
        ...themes,
        SettingsDivider(),
        AboutTile(
          child: Text.rich(
            TextSpan(
              text: i18n.systemThemeDescription,
              children: [
                TextSpan(text: '\r\n\r\n'),
                TextSpan(
                  text: i18n.darkThemeDescription,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
