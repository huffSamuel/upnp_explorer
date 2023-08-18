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

  @override
  Widget build(BuildContext context) {
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
        // tileColor: value
        //     ? theme.switchTheme.thumbColor!.resolve({MaterialState.selected})
        //     : ElevationOverlay.applySurfaceTint(
        //         theme.switchTheme.thumbColor!
        //             .resolve({MaterialState.selected})!,
        //         theme.colorScheme.surfaceTint,
        //         3,
        //       ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
