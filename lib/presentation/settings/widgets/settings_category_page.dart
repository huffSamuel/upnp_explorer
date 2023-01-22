import 'package:flutter/material.dart';
import 'package:upnp_explorer/presentation/core/page/app_page.dart';

class SettingsCategoryPage extends StatelessWidget {
  final String category;
  final List<Widget> children;

  const SettingsCategoryPage({
    Key? key,
    required this.category,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: Text(category),
      children: children,
    );
  }
}
