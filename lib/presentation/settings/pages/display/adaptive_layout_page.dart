import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/options.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings/switch_tile.dart';
import '../../widgets/settings_category_page.dart';

class AdaptiveLayoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = Options.of(context).material3;
    final i18n = AppLocalizations.of(context)!;

    return SettingsCategoryPage(
      category: i18n.adaptiveLayout,
      children: [
        SwitchTile(
          title: Text(i18n.adaptiveLayout),
          value: value,
          onChanged: (v) {
            final options = Options.of(context);

            Options.update(
              context,
              options.copyWith(material3: v),
            );
          },
        ),
        AboutTile(
          child: Text(
            i18n.adaptiveLayoutDescription,
          ),
        ),
      ],
    );
  }
}
