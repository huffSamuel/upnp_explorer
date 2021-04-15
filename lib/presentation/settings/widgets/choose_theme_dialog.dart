import 'package:flutter/material.dart';
import 'package:ssdp/data/options.dart';
import 'package:ssdp/generated/l10n.dart';

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

    final children = ThemeMode.values
        .map(
          (value) => RadioListTile(
            value: value,
            groupValue: options.themeMode,
            onChanged: (v) => Options.update(
              context,
              options.copyWith(themeMode: v),
            ),
            title: Text(i18n.themeMode(value)),
          ),
        )
        .toList();

    return SimpleDialog(
      title: Text(i18n.chooseTheme),
      children: children,
    );
  }
}
