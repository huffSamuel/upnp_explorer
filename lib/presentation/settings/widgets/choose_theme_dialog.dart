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
              if (v == null) {
                return;
              }

              Options.update(
                context,
                options.copyWith(themeMode: v),
              );
              Navigator.of(context).pop();
            },
            title: Text(i18n.themeMode(value)),
          ),
        )
        .toList();

    return AlertDialog(
      title: Text(i18n.chooseTheme),
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Column(children: [...themes]),
    );
  }
}
