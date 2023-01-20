import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infrastructure/upnp/search_request_builder.dart';
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

  @preResolve
  Future<UserAgentBuilder> get userAgentBuilder => UserAgentBuilder.create();
}
