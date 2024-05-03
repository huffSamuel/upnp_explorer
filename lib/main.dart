import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'presentation/device/pages/service.dart';

import 'application/application.dart';
import 'application/ioc.dart';
import 'application/licenses.dart';
import 'application/settings/options.dart';
import 'application/settings/options_repository.dart';
import 'application/settings/palette.dart';
import 'presentation/core/widgets/model_binding.dart';
import 'presentation/device/pages/discovery_page.dart';

void main() {
  registerLicenses();

  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies().then(
    (_) => runApp(
      ModelBinding(
        initialModel: sl<SettingsRepository>().get(),
        onUpdate: (c, m) {
          sl<SettingsRepository>().set(m).then((_) async {
            if (c?.protocolOptions == m.protocolOptions) {
              return;
            }
            
            final svc = sl<DiscoveryStateService>();
            await svc.update(m.protocolOptions);
          });
        },
        child: MyApp(
          optionsRepository: sl(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SettingsRepository optionsRepository;

  const MyApp({
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
