import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'theme_settings_page.dart';
import 'visual_density_page.dart';

import '../../../../application/settings/options.dart';
import '../../../../domain/value_converter.dart';
import '../../../core/widgets/model_binding.dart';
import '../../widgets/settings_category_page.dart';
import '../../widgets/settings_category_tile.dart';

class DisplaySettingsPage extends StatelessWidget {
  Function() _openPage(BuildContext context, Widget page) {
    return () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final options = ModelBinding.of<Settings>(context);

    return SettingsCategoryPage(
      category: i18n.display,
      children: [
        SettingsTile(
          title: Text(i18n.theme),
          subtitle: Text(i18n.themeMode(options.themeMode.name)),
          leading: Icon(Icons.brightness_medium_outlined),
          onTap: _openPage(
            context,
            ThemeSettingsPage(),
          ),
        ),
        SettingsTile(
          title: Text(i18n.density),
          leading: Icon(Icons.density_medium_rounded),
          subtitle: Text(
            i18n.visualDensity(
              kVisualDensityConverter
                  .from(
                    options.visualDensity,
                  )
                  .name,
            ),
          ),
          onTap: _openPage(context, VisualDensityPage()),
        ),
      ],
    );
  }
}
