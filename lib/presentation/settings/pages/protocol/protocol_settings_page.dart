import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/settings.dart';
import '../../widgets/settings_category_page.dart';
import '../../widgets/settings_category_tile.dart';
import 'advanced_mode_page.dart';
import 'maximum_response_delay_page.dart';
import 'multicast_hops_page.dart';

class ProtocolSettingsPage extends StatelessWidget {
  const ProtocolSettingsPage();

  Function() _openPage(BuildContext context, Widget page) {
    return () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final options = Settings.of(context);

    return SettingsCategoryPage(
      category: i18n.discovery,
      children: [
        SettingsTile(
          title: Text(i18n.maxResponseDelay),
          leading: Icon(Icons.timer_outlined),
          subtitle: Text(i18n.responseDelay(options.protocolOptions.maxDelay)),
          onTap: _openPage(context, MaximumResponseDelayPage()),
        ),
        SettingsTile(
          title: Text(i18n.multicastHops),
          leading: Icon(Icons.network_ping_rounded),
          subtitle: Text(options.protocolOptions.hops.toString()),
          onTap: _openPage(context, MulticastHopsPage()),
        ),
        SettingsTile(
          title: Text(i18n.advancedMode),
          leading: Icon(Icons.admin_panel_settings_outlined),
          subtitle: Text(options.protocolOptions.advanced ? i18n.on : i18n.off),
          onTap: _openPage(context, AdvancedModePage()),
        ),
      ],
    );
  }
}
