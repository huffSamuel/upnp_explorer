import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnp_explorer/libraries/simple_upnp/src/upnp.dart';
import 'device.dart';
import 'settings/options_repository.dart';

import 'ioc.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initIoc',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies({String environment = 'prd'}) => $initIoc(
      sl,
      environment: environment,
    );

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Connectivity get connectivity => Connectivity();
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  @preResolve
  Future<SimpleUPNP> upnp(
    DeviceInfo deviceInfo,
    SettingsRepository settingsRepo,
  ) async {
    final i = SimpleUPNP.instance();

    await i.start(Options());

    return i;
  }
}
