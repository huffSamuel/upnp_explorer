import 'package:flutter/material.dart';
import 'package:upnp_explorer/application/application.dart';
import 'package:upnp_explorer/extension/build_context.dart';

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
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          child: Text(i18n.settings),
        ),
      ),
      body: ListView(
        children: [
          SettingsCategoryCard(
            title: Text(i18n.display),
            subtitle: Text(i18n.theme),
            icon: Icons.display_settings,
            onTap: _nav(
              context,
              DisplaySettingsPage(),
            ),
          ),
          SettingsCategoryCard(
            title: Text(i18n.discovery),
            subtitle: Text(i18n.discoverySubtitle),
            icon: Icons.search,
            onTap: _nav(
              context,
              ProtocolSettingsPage(),
            ),
          ),
          SettingsCategoryCard(
            title: Text(i18n.about),
            subtitle: Text(Application.name),
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