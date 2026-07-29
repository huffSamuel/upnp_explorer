import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upnp_explorer/features/settings/presentation/pages/settings_page.dart';

import '../../../discovery/presentation/pages/explorer_page.dart';
import '../../../logs/presentation/pages/logs_page.dart';

final router = GoRouter(
  initialLocation: '/explore',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        switch (state.matchedLocation) {}

        return ViewHost(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/explore',
            builder: (context, state) => ExplorerPage(),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/messages',
            builder: (context, state) => LogsPage(),
          )
        ]),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ViewHost extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ViewHost({super.key, required this.shell});

  void _onTap(BuildContext context, int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.terminal),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        onTap: (value) => _onTap(context, value),
      ),
    );
  }
}
