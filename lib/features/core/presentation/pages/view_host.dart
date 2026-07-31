import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../application/ioc.dart';
import '../../../discovery/presentation/pages/device_info_page.dart';
import '../../../discovery/presentation/pages/explorer_page.dart';
import '../../../discovery/service/device_service.dart';
import '../../../logs/presentation/pages/logs_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import 'changelog_page.dart';

final router = GoRouter(
  initialLocation: '/explore',
  routes: [
    GoRoute(path: '/changelog', builder: (context, state) => ChangelogPage()),
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
          ),
          GoRoute(
              path: '/device/:udn',
              builder: (context, state) {
                final udn = state.pathParameters['udn'];
                final device = sl<DeviceService>()
                    .devices
                    .singleWhere((d) => d.description.udn == udn);
                return DeviceInfoPage(device: device);
              }),
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (shell.currentIndex != 0) {
          _onTap(context, 0);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
