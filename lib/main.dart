import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants.dart';
import 'data/options.dart';
import 'data/options_repository.dart';
import 'data/palette.dart';
import 'generated/l10n.dart';
import 'infrastructure/services/device_discovery_service.dart';
import 'infrastructure/services/ioc.dart';
import 'presentation/device/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeService().then((_) => runApp(MyApp(
        optionsRepository: sl(),
      )));
}

class MyApp extends StatelessWidget {
  final OptionsRepository optionsRepository;

  const MyApp({
    Key key,
    this.optionsRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialModel = optionsRepository.get();

    return ModelBinding(
      initialModel: initialModel,
      child: Builder(
        builder: (context) {
          final options = Options.of(context);

          if (options != optionsRepository.get()) {
            optionsRepository.set(options);
          }

          sl<DeviceDiscoveryService>().protocolOptions =
              options.protocolOptions;

          return MaterialApp(
            title: kAppName,
            themeMode: options.themeMode,
            darkTheme: Palette.instance.darkTheme(options),
            theme: Palette.instance.lightTheme(options),
            localizationsDelegates: localizationDelegates,
            supportedLocales: S.delegate.supportedLocales,
            home: DeviceList(),
          );
        },
      ),
    );
  }
}

List<LocalizationsDelegate> localizationDelegates = [
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
