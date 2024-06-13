import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'application/flavors/flavor_features.dart';
import 'application/ioc.dart';
import 'application/licenses.dart';
import 'application/settings/settings_repository.dart';
import 'presentation/core/widgets/model_binding.dart';
import 'presentation/device/pages/service.dart';
import 'upnp_explorer.dart';

Future<void> runAppWithFeatures(FlavorFeatures features) async {
  registerLicenses();

  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  GetIt.instance.registerSingleton<FlavorFeatures>(features);

  final settings = await sl<SettingsRepository>().get();

  runApp(
    ModelBinding(
      initialModel: settings,
      onUpdate: (c, m) {
        sl<SettingsRepository>().set(m).then((_) async {
          if (c?.protocolOptions == m.protocolOptions) {
            return;
          }

          final svc = sl<DiscoveryStateService>();
          await svc.update(m.protocolOptions);
        });
      },
      child: UPnPExplorer(
        optionsRepository: sl(),
      ),
    ),
  );
}
