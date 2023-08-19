import 'package:flutter/material.dart';

class HighlightSwitchTile extends StatelessWidget {
  final Widget title;
  final bool value;
  final void Function(bool)? onChanged;

  const HighlightSwitchTile({
    required this.title,
    required this.value,
    this.onChanged,
  });

  Color? _activeColor(ColorScheme? colorScheme) {
    if (colorScheme == null) {
      return null;
    }

    return ElevationOverlay.applySurfaceTint(
      colorScheme.surface,
      colorScheme.surfaceTint,
      20,
    );
  }

  Color? _inactiveColor(ColorScheme? colorScheme) {
    if (colorScheme == null) {
      return null;
    }

    return ElevationOverlay.applySurfaceTint(
        colorScheme.surface, colorScheme.surfaceTint, 1);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              fontSize: 20.0,
            ),
            child: title,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        tileColor:
            value ? _activeColor(colorScheme) : _inactiveColor(colorScheme),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
