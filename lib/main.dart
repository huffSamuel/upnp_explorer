import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'application/application.dart';
import 'application/ioc.dart';
import 'application/l10n/generated/l10n.dart';
import 'application/routing/routes.dart';
import 'application/settings/options.dart';
import 'application/settings/palette.dart';
import 'infrastructure/settings/options_repository.dart';
import 'infrastructure/ssdp/device_discovery_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies().then((_) => runApp(MyApp(optionsRepository: sl())));
}

class MyApp extends StatelessWidget {
  final SettingsRepository optionsRepository;

  MyApp({
    Key? key,
    required this.optionsRepository,
  }) : super(key: key) {
    Application.router = Routes.configure(FluroRouter());
  }

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
            title: Application.name,
            themeMode: options.themeMode,
            darkTheme: Palette.instance.darkTheme(options),
            theme: Palette.instance.lightTheme(options),
            localizationsDelegates: localizationDelegates,
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: Application.router!.generator,
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
