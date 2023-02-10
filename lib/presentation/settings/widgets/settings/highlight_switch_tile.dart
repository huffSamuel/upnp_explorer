import 'package:flutter/material.dart';
import 'switch_tile.dart';

class HighlightSwitchTile extends StatelessWidget {
  final Widget title;
  final bool value;
  final Color? activeColor;
  final void Function(bool)? onChanged;

  const HighlightSwitchTile({
    required this.title,
    required this.value,
    this.onChanged,
    this.activeColor,
  });

  Color _color(BuildContext context) {
    final theme = Theme.of(context);

    if (!value) {
      return theme.disabledColor;
    }

    return activeColor ??
        theme.switchTheme.thumbColor!.resolve({MaterialState.selected}) ??
        theme.toggleableActiveColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.useMaterial3) {
      return _buildMaterial3(theme);
    }

    return Ink(
      color: _color(context),
      child: SwitchTile(
        activeColor: Colors.white,
        title: DefaultTextStyle.merge(
          child: title,
          style: TextStyle(color: Colors.white),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Padding _buildMaterial3(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListTile(
        onTap: () => onChanged?.call(!value),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? theme.colorScheme.onInverseSurface
                  : theme.colorScheme.onSurface,
              fontSize: 20.0,
            ),
            child: title,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        tileColor: value
            ? theme.switchTheme.thumbColor!.resolve({MaterialState.selected})
            : ElevationOverlay.applySurfaceTint(
                theme.switchTheme.thumbColor!
                    .resolve({MaterialState.selected})!,
                theme.colorScheme.surfaceTint,
                3,
              ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
        ),
      ),
    );
  }
}
