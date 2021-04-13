import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: localizationDelegates,
      supportedLocales: S.delegate.supportedLocales,
      home: DeviceList(),
    );
  }
}

List<LocalizationsDelegate> localizationDelegates = [
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
