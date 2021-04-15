import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ssdp/data/options.dart';

import 'constants.dart';
import 'generated/l10n.dart';
import 'infrastructure/services/ioc.dart';
import 'presentation/device/pages/home.dart';

void main() {
  initializeService().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: Options(
        themeMode: ThemeMode.system,
        visualDensity: VisualDensity.standard,
      ),
      child: Builder(builder: (context) {
        final options = Options.of(context);

        return MaterialApp(
          title: kAppName,
          themeMode: options.themeMode,
          darkTheme:
              ThemeData.dark().copyWith(visualDensity: options.visualDensity),
          theme:
              ThemeData.light().copyWith(visualDensity: options.visualDensity),
          localizationsDelegates: localizationDelegates,
          supportedLocales: S.delegate.supportedLocales,
          home: DeviceList(),
        );
      }),
    );
  }
}

List<LocalizationsDelegate> localizationDelegates = [
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
