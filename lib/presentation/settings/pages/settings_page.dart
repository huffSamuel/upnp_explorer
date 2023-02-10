import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/application.dart';
import '../../core/page/app_page.dart';
import '../widgets/settings/category_tile.dart';
import 'about/about_settings_page.dart';
import 'display/display_settings_page.dart';
import 'protocol/protocol_settings_page.dart';

Function() _nav(BuildContext context, Widget page) {
  return () =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

class MaterialDesignSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    final children = <Widget>[
      CategoryTile(
        leading: Icon(Icons.display_settings),
        leadingBackgroundColor: Colors.amber[700],
        title: Text(i18n.display),
        subtitle: Text('${i18n.theme}, ${i18n.density}'),
        onTap: _nav(
          context,
          DisplaySettingsPage(),
        ),
      ),
      CategoryTile(
        leading: Icon(Icons.wifi_tethering_rounded),
        leadingBackgroundColor: Colors.deepPurpleAccent,
        title: Text(i18n.discovery),
        subtitle: Text('${i18n.maxResponseDelay}, ${i18n.multicastHops}'),
        onTap: _nav(
          context,
          ProtocolSettingsPage(),
        ),
      ),
      CategoryTile(
        leading: Icon(Icons.info_outline_rounded),
        leadingBackgroundColor: Colors.grey[700],
        title: Text(i18n.about),
        subtitle: Text(Application.name),
        onTap: _nav(
          context,
          AboutSettingsPage(),
        ),
      ),
    ];

    return AppPage(
      title: Text(i18n.settings),
      children: children,
    );
  }
}
