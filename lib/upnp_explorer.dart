import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'application/application.dart';
import 'application/l10n/app_localizations.dart';
import 'application/settings/palette.dart';
import 'application/settings/settings.dart';
import 'presentation/device/pages/discovery_page.dart';

class UPnPExplorer extends StatelessWidget {
  const UPnPExplorer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = Settings.of(context);

    return DynamicColorBuilder(builder: (
      ColorScheme? lightDynamic,
      ColorScheme? darkDynamic,
    ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Application.name,
        themeMode: options.themeMode,
        darkTheme: AppTheme.dark(
          darkDynamic,
          options.visualDensity,
        ),
        theme: AppTheme.light(
          lightDynamic,
          options.visualDensity,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DiscoveryPage(),
      );
    });
  }
}
