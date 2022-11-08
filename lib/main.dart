import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'application/application.dart';
import 'application/ioc.dart';
import 'application/l10n/generated/l10n.dart';
import 'application/settings/options_repository.dart';
import 'application/routing/routes.dart';
import 'application/settings/options.dart';
import 'application/settings/palette.dart';
import 'infrastructure/upnp/device_discovery_service.dart';
import 'presentation/core/widgets/model_binding.dart';
import 'presentation/service/bloc/command_bloc.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    final animatedListLicense = await rootBundle
        .loadString('assets/automatic_animated_list/license.txt');
    yield LicenseEntryWithLineBreaks(
        ['automatic_animated_list'], animatedListLicense);
  });

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

          return BlocProvider.value(
            value: sl<CommandBloc>(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Application.name,
              themeMode: options.themeMode,
              darkTheme: Palette.instance.darkTheme(options),
              theme: Palette.instance.lightTheme(options),
              localizationsDelegates: localizationDelegates,
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: Application.router!.generator,
            ),
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
