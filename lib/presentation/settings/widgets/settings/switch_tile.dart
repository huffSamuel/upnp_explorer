import 'package:flutter/material.dart';

import '../settings_category_tile.dart';

class SwitchTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final bool value;
  final void Function(bool)? onChanged;
  final Color? activeColor;

  const SwitchTile({
    this.leading,
    required this.title,
    required this.value,
    this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      onTap: () => onChanged?.call(!value),
      title: title,
      leading: leading,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      ),
    );
  }
}
