// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;
import 'package:upnped/upnped.dart' as _i11;

import '../presentation/device/pages/service.dart' as _i12;
import 'bug_report_service.dart' as _i3;
import 'changelog/changelog_service.dart' as _i9;
import 'contributor_service.dart' as _i5;
import 'ioc.dart' as _i13;
import 'logger_factory.dart' as _i6;
import 'network_logs/network_event_service.dart' as _i7;
import 'settings/options_repository.dart' as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initIoc(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.BugReportService>(() => _i3.BugReportService());
  gh.factory<_i4.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i5.ContributorsService>(() => _i5.ContributorsService());
  gh.lazySingleton<_i6.LoggerFactory>(() => _i6.LoggerFactory());
  gh.singleton<_i7.NetworkEventService>(_i7.NetworkEventService());
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i9.ChangelogService>(
      () => _i9.ChangelogService(gh<_i8.SharedPreferences>()));
  gh.lazySingleton<_i10.SettingsRepository>(
      () => _i10.SettingsRepository(gh<_i8.SharedPreferences>()));
  await gh.factoryAsync<_i11.Server>(
    () => registerModule.upnp(gh<_i10.SettingsRepository>()),
    preResolve: true,
  );
  gh.singleton<_i12.DiscoveryStateService>(_i12.DiscoveryStateService(
    gh<_i4.Connectivity>(),
    gh<_i11.Server>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i13.RegisterModule {}
