import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upnped/upnped.dart';

import 'ioc.config.dart';
import 'settings/settings_repository.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initIoc',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies({String environment = Environment.prod}) =>
    $initIoc(
      sl,
      environment: environment,
    );

@module
abstract class RegisterModule {
  @Environment(Environment.prod)
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @Environment(Environment.prod)
  Connectivity get connectivity => Connectivity();

  @Environment(Environment.prod)
  @preResolve
  Future<Server> upnp(
    SettingsRepository settingsRepo,
  ) async {
    final i = Server.getInstance();
    final settings = await settingsRepo.get();

    await i.listen(Options(
      multicastHops: settings.protocolOptions.hops,
    ));

    return i;
  }
}
