import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../application/settings/options.dart';

void showThemeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return ChooseThemeDialog();
    },
  );
}

class ChooseThemeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    final themes = ThemeMode.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: options.themeMode,
            onChanged: (ThemeMode? v) {
              if(v == null) {
                return;
              }

              Options.update(
                context,
                options.copyWith(themeMode: v),
              );
            },
            title: Text(i18n.themeMode(value)),
          ),
        )
        .toList();

    final children = [
      ...themes,
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
      title: Text(i18n.chooseTheme),
      children: children,
    );
  }
}
