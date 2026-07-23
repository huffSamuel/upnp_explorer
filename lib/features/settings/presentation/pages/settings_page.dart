import 'package:flutter/material.dart';

import '../../../core/presentation/widgets/my_bottom_app_bar.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/my_icon.dart';
import '../../../core/presentation/widgets/page_title.dart';
import 'about_page.dart';
import 'display_settings_page.dart';
import 'protocol_page.dart';

Function() _nav(BuildContext context, Widget page) {
  return () =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: MyBottomAppBar(currentIndex: 2),
      appBar: AppBar(
        title: PageTitle(
          child: Text('Settings'),
        ),
      ),
      body: ListView(
        children: [
          SettingsCategoryCard(
            title: Text('Display'),
            subtitle: Text('Theme, Visual Density'),
            icon: Icons.display_settings,
            onTap: _nav(
              context,
              DisplaySettingsPage(),
            ),
          ),
          SettingsCategoryCard(
            title: Text('Discovery'),
            subtitle: Text('Delay, Hops'),
            icon: Icons.search,
            onTap: _nav(
              context,
              ProtocolSettingsPage(),
            ),
          ),
          SettingsCategoryCard(
            title: Text('About'),
            subtitle: Text('UPnP Explorer'),
            icon: Icons.info,
            onTap: _nav(
              context,
              AboutSettingsPage(),
            ),
          )
        ],
      ),
    );
  }
}

class SettingsCategoryCard extends StatelessWidget {
  final Widget title;
  final IconData icon;
  final Widget subtitle;
  final VoidCallback onTap;

  const SettingsCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MyCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyIcon(
              icon: icon,
              backgroundColor: theme.colorScheme.surfaceContainerLow,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: -.25,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    child: title,
                  ),
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: theme.hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                    child: subtitle,
                  )
                ],
              ),
            ),
            SizedBox(width: 12),
            Align(
              alignment: Alignment.center,
              child: Icon(Icons.chevron_right, color: theme.hintColor),
            ),
          ],
        ),
      ),
    );
  }
}