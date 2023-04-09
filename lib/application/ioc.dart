import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnp_explorer/domain/upnp/upnp.dart';
import 'package:upnp_explorer/application/device.dart';
import 'package:upnp_explorer/application/settings/options_repository.dart';

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

  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  UpnpDiscovery upnp(DeviceInfo deviceInfo, SettingsRepository settingsRepo) {
    final settings = settingsRepo.get();

    return UpnpDiscovery(
      Options(
        osUserAgent: '${deviceInfo.os}/${deviceInfo.osVersion}',
        multicastHops: settings.protocolOptions.hops,
        maxDelay: settings.protocolOptions.maxDelay,
      ),
    );
  }
}
