// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:device_info_plus/device_info_plus.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../domain/network_logs/network_logs_repository_type.dart' as _i8;
import '../packages/upnp/upnp.dart' as _i15;
import '../presentation/device/pages/service.dart' as _i16;
import 'bug_report_service.dart' as _i3;
import 'changelog/changelog_service.dart' as _i11;
import 'contributor_service.dart' as _i5;
import 'device.dart' as _i12;
import 'ioc.dart' as _i17;
import 'logger_factory.dart' as _i7;
import 'network_logs/network_logs_repository.dart' as _i9;
import 'review/review_service.dart' as _i13;
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
  gh.singleton<_i8.NetworkLogsRepositoryType>(_i9.NetworkLogsRepository());
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i11.ChangelogService>(
      () => _i11.ChangelogService(gh<_i10.SharedPreferences>()));
  await gh.lazySingletonAsync<_i12.DeviceInfo>(
    () => _i12.DeviceInfo.create(gh<_i6.DeviceInfoPlugin>()),
    preResolve: true,
  );
  gh.lazySingleton<_i13.ReviewService>(
      () => _i13.ReviewService(gh<_i10.SharedPreferences>()));
  gh.lazySingleton<_i14.SettingsRepository>(
      () => _i14.SettingsRepository(gh<_i10.SharedPreferences>()));
  gh.factory<_i15.UpnpDiscovery>(() => registerModule.upnp(
        gh<_i12.DeviceInfo>(),
        gh<_i14.SettingsRepository>(),
      ));
  gh.singleton<_i16.DiscoveryStateService>(_i16.DiscoveryStateService(
    gh<_i4.Connectivity>(),
    gh<_i15.UpnpDiscovery>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i17.RegisterModule {}
