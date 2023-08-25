// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:device_info_plus/device_info_plus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../domain/network_logs/network_logs_repository_type.dart' as _i7;
import '../packages/upnp/upnp.dart' as _i14;
import '../presentation/device/pages/service.dart' as _i15;
import 'bug_report_service.dart' as _i3;
import 'changelog/changelog_service.dart' as _i10;
import 'device.dart' as _i11;
import 'ioc.dart' as _i16;
import 'logger_factory.dart' as _i6;
import 'network_logs/network_logs_repository.dart' as _i8;
import 'review/review_service.dart' as _i12;
import 'settings/options_repository.dart' as _i13;

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
  gh.factory<_i5.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.lazySingleton<_i6.LoggerFactory>(() => _i6.LoggerFactory());
  gh.singleton<_i7.NetworkLogsRepositoryType>(_i8.NetworkLogsRepository());
  await gh.factoryAsync<_i9.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i10.ChangelogService>(
      () => _i10.ChangelogService(gh<_i9.SharedPreferences>()));
  await gh.lazySingletonAsync<_i11.DeviceInfo>(
    () => _i11.DeviceInfo.create(gh<_i5.DeviceInfoPlugin>()),
    preResolve: true,
  );
  gh.lazySingleton<_i12.ReviewService>(
      () => _i12.ReviewService(gh<_i9.SharedPreferences>()));
  gh.lazySingleton<_i13.SettingsRepository>(
      () => _i13.SettingsRepository(gh<_i9.SharedPreferences>()));
  gh.factory<_i14.UpnpDiscovery>(() => registerModule.upnp(
        gh<_i11.DeviceInfo>(),
        gh<_i13.SettingsRepository>(),
      ));
  gh.singleton<_i15.DiscoveryStateService>(_i15.DiscoveryStateService(
    gh<_i4.Connectivity>(),
    gh<_i14.UpnpDiscovery>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i16.RegisterModule {}
