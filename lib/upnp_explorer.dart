import 'package:flutter/material.dart';
import 'package:upnp_explorer/features/core/theme.dart';

import 'application/application.dart';
import 'application/l10n/app_localizations.dart';
import 'application/settings/settings.dart';
import 'features/core/presentation/pages/view_host.dart';

class UPnPExplorer extends StatelessWidget {
  const UPnPExplorer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final options = Settings.of(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Application.name,
      themeMode: options.themeMode,
      darkTheme: AppTheme.dark(oled: options.oledDark),
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
