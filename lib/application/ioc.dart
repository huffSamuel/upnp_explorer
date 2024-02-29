import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../libraries/simple_upnp/src/upnp.dart';
import 'ioc.config.dart';
import 'settings/options_repository.dart';

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
    SettingsRepository settingsRepo,
  ) async {
    final i = SimpleUPNP.instance();
    final settings = settingsRepo.get();

    await i.start(Options(
      ipv4: true,
      ipv6: true,
      multicastHops: settings.protocolOptions.hops,
      maxDelay: settings.protocolOptions.maxDelay,
    ));

    return i;
  }
}
