import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';

class ExecuteActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExecuteActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: DefaultTextStyle.merge(
          style: TextStyle(fontSize: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow, size: 24),
              const SizedBox(width: 4),
              Text(context.i18n().executeAction),
            ],
          ),
        ),
      ),
    );
  }
}