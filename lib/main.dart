import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'application/application.dart';
import 'application/device.dart';
import 'application/ioc.dart';
import 'application/licenses.dart';
import 'application/network_logs/filter_state.dart';
import 'application/settings/options.dart';
import 'application/settings/options_repository.dart';
import 'application/settings/palette.dart';
import 'packages/upnp/upnp.dart';
import 'presentation/core/widgets/model_binding.dart';
import 'presentation/device/pages/discovery_page.dart';

void main() {
  registerLicenses();

  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies().then(
    (_) => runApp(
      ModelBinding(
        initialModel: FilterState(filters: []),
        child: ModelBinding(
          initialModel: sl<SettingsRepository>().get(),
          onUpdate: (m) {
            final device = sl<DeviceInfo>();
            sl<SettingsRepository>().set(m);
            sl<UpnpDiscovery>().options(
              Options(
                osUserAgent: '${device.os}/${device.osVersion}',
                maxDelay: m.protocolOptions.maxDelay,
                multicastHops: m.protocolOptions.hops,
              ),
            );
          },
          child: MyApp(
            optionsRepository: sl(),
          ),
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
        darkTheme: Palette.makeTheme(
            darkDynamic, Brightness.dark, options.visualDensity),
        theme: Palette.makeTheme(
          lightDynamic,
          Brightness.light,
          options.visualDensity,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DiscoveryPage(),
      );
    });
  }
}
