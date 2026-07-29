import 'package:flutter/material.dart';

class SettingDescription extends StatelessWidget {
  final Widget child;

  const SettingDescription({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Theme.of(context).hintColor,
        height: 1.3,
      ),
      child: child,
    );
  }
}
