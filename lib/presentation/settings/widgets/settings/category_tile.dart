import 'package:flutter/material.dart';

import '../settings_category_tile.dart';

class CategoryTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final VoidCallback? onTap;
  final Color? leadingBackgroundColor;
  final Color? leadingForegroundColor;

  const CategoryTile({
    Key? key,
    this.leading,
    this.leadingBackgroundColor,
    this.leadingForegroundColor,
    required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget? effectiveLeading;

    if (leading != null && leadingBackgroundColor != null) {
      effectiveLeading = CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        child: leading,
      );
    } else if (leading != null) {
      effectiveLeading = leading;
    }

    return SettingsTile(
      leading: effectiveLeading,
      title: title,
      subtitle: subtitle ?? const Text(''),
      onTap: onTap,
    );
  }
}
