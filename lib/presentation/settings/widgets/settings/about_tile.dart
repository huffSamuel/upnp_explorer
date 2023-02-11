import 'package:flutter/material.dart';

import '../settings_category_tile.dart';

class AboutTile extends StatelessWidget {
  final Widget child;

  const AboutTile({
    required this.child,
  });

  Widget _buildMaterial2Tile(BuildContext context, ThemeData theme) {
    return SettingsTile(
      title: Container(height: 12.0),
      subtitle: DefaultTextStyle(
        child: child,
        style: theme.textTheme.bodyMedium!.copyWith(color: theme.disabledColor),
      ),
      leading: Icon(Icons.info_outline_rounded),
      centerLeading: false,
    );
  }

  Widget _buildMaterial3Tile(
    BuildContext context,
    ThemeData theme,
  ) {
    return ListTile(
      title: Container(height: 12.0),
      subtitle: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22.0),
            Icon(
              Icons.info_outline_rounded,
              color: theme.colorScheme.onBackground,
            ),
            const SizedBox(height: 22.0),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.useMaterial3) {
      return _buildMaterial3Tile(context, theme);
    }

    return _buildMaterial2Tile(context, theme);
  }
}
