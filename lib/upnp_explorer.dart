import 'package:flutter/material.dart';
import 'package:upnp_explorer/features/logs/presentation/pages/logs_page.dart';
import 'package:upnp_explorer/features/settings/presentation/pages/settings_page.dart';
import 'features/core/dark.dart';
import 'features/core/light.dart';

import 'application/application.dart';
import 'application/l10n/app_localizations.dart';
import 'application/settings/settings.dart';
import 'features/discovery/presentation/pages/explorer_page.dart';

class UPnPExplorer extends StatelessWidget {
  const UPnPExplorer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = Settings.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Application.name,
      themeMode: options.themeMode,
      darkTheme: PrecisionObserverDarkTheme.darkTheme,
      theme: PrecisionObserverTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ExplorerPage(),
    );
  }
}
