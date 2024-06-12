import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'application/application.dart';
import 'application/settings/options.dart';
import 'application/settings/options_repository.dart';
import 'application/settings/palette.dart';
import 'presentation/device/pages/discovery_page.dart';



class UPnPExplorer extends StatelessWidget {
  final SettingsRepository optionsRepository;

  const UPnPExplorer({
    Key? key,
    required this.optionsRepository,
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
