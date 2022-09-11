import 'package:flutter/material.dart';

class SettingsCategoryPage extends StatelessWidget {
  final String category;
  final List<Widget> children;
  final List<Widget>? actions;

  const SettingsCategoryPage({
    Key? key,
    required this.category,
    required this.children,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
        elevation: 3.0,
        title: Text(category),
        actions: actions,
      ),
      body: ListView(
        children: children,
      ),
    );
  }
}
