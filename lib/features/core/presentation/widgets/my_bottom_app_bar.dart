import 'package:flutter/material.dart';
import 'package:upnp_explorer/extension/build_context.dart';

import '../../../discovery/presentation/pages/explorer_page.dart';
import '../../../logs/presentation/pages/logs_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';

class MyBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final GlobalKey<NavigatorState>? navigator;
  final void Function(int)? changeIndex;

  const MyBottomAppBar({
    super.key,
    required this.currentIndex,
    this.navigator,
    this.changeIndex,
  });

  void _onTap(int? index, BuildContext context) {
    if (index == currentIndex) {
      return;
    }

    final target = switch (index) {
      0 => ExplorerPage(),
      1 => LogsPage(),
      2 => SettingsPage(),
      _ => throw Exception()
    };

    changeIndex?.call(index!);

    final n = navigator?.currentState ?? Navigator.of(context);

    n.push(MaterialPageRoute(builder: (context) => target));
  }

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    return BottomNavigationBar(
      onTap: (index) => _onTap(index, context),
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: i18n.explorer,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.terminal),
          label: i18n.messages,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: i18n.settings,
        )
      ],
      useLegacyColorScheme: false,
    );
  }
}
