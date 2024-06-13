import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/settings.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings/highlight_switch_tile.dart';
import '../../widgets/settings_category_page.dart';

class AdvancedModePage extends StatelessWidget {
  const AdvancedModePage();

  @override
  Widget build(BuildContext context) {
    final options = Settings.of(context);
    final i18n = AppLocalizations.of(context)!;

    return SettingsCategoryPage(
      category: i18n.advancedMode,
      children: [
        const SizedBox(height: 20),
        HighlightSwitchTile(
          title: Text(i18n.advancedMode),
          value: options.protocolOptions.advanced,
          onChanged: (v) => Settings.update(
            context,
            options.copyWith(
              protocolOptions: options.protocolOptions.copyWith(
                advanced: v,
              ),
            ),
          ),
        ),
        AboutTile(
          child: Text(i18n.advancedModeWarning),
        ),
      ],
    );
  }
}
