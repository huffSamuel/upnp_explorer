import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'application/flavors/flavor_features.dart';
import 'application/flavors/google/google_features.dart';
import 'application/ioc.dart';
import 'application/licenses.dart';
import 'application/settings/options_repository.dart';
import 'presentation/core/widgets/model_binding.dart';
import 'presentation/device/pages/service.dart';
import 'upnp_explorer.dart';

Future<void> main() async {
  registerLicenses();

  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  GetIt.instance.registerSingleton<FlavorFeatures>(GoogleFeatures());
  runApp(
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
      child: UPnPExplorer(
        optionsRepository: sl(),
      ),
    ),
  );
}