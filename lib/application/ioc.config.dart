// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:device_info_plus/device_info_plus.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../domain/network_logs/network_logs_repository_type.dart' as _i9;
import '../presentation/device/pages/service.dart' as _i16;
import '../simple_upnp/simple_upnp.dart' as _i17;
import '../simple_upnp/src/upnp.dart' as _i15;
import 'bug_report_service.dart' as _i3;
import 'changelog/changelog_service.dart' as _i12;
import 'contributor_service.dart' as _i5;
import 'device.dart' as _i13;
import 'ioc.dart' as _i18;
import 'logger_factory.dart' as _i7;
import 'network_logs/network_event_service.dart' as _i8;
import 'network_logs/network_logs_repository.dart' as _i10;
import 'settings/options_repository.dart' as _i14;

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
  gh.factory<_i6.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.lazySingleton<_i7.LoggerFactory>(() => _i7.LoggerFactory());
  gh.singleton<_i8.NetworkEventService>(_i8.NetworkEventService());
  gh.singleton<_i9.NetworkLogsRepositoryType>(_i10.NetworkLogsRepository());
  await gh.factoryAsync<_i11.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i12.ChangelogService>(
      () => _i12.ChangelogService(gh<_i11.SharedPreferences>()));
  await gh.lazySingletonAsync<_i13.DeviceInfo>(
    () => _i13.DeviceInfo.create(gh<_i6.DeviceInfoPlugin>()),
    preResolve: true,
  );
  gh.lazySingleton<_i14.SettingsRepository>(
      () => _i14.SettingsRepository(gh<_i11.SharedPreferences>()));
  await gh.factoryAsync<_i15.SimpleUPNP>(
    () => registerModule.upnp(
      gh<_i13.DeviceInfo>(),
      gh<_i14.SettingsRepository>(),
    ),
    preResolve: true,
  );
  gh.singleton<_i16.DiscoveryStateService>(_i16.DiscoveryStateService(
    gh<_i4.Connectivity>(),
    gh<_i17.SimpleUPNP>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i18.RegisterModule {}
