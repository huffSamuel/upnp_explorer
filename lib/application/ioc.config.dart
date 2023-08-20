// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;
import 'package:upnp_explorer/application/changelog/changelog_service.dart'
    as _i9;
import 'package:upnp_explorer/application/device.dart' as _i10;
import 'package:upnp_explorer/application/logger_factory.dart' as _i5;
import 'package:upnp_explorer/application/network_logs/network_logs_repository.dart'
    as _i7;
import 'package:upnp_explorer/application/review/review_service.dart' as _i11;
import 'package:upnp_explorer/application/settings/options_repository.dart'
    as _i12;
import 'package:upnp_explorer/domain/network_logs/network_logs_repository_type.dart'
    as _i6;
import 'package:upnp_explorer/packages/upnp/upnp.dart' as _i13;
import 'package:upnp_explorer/application/bug_report_service.dart'
    as _i3;
import 'package:upnp_explorer/presentation/core/bloc/application_bloc.dart'
    as _i14;

import 'ioc.dart' as _i15;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
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
  gh.factory<_i4.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.lazySingleton<_i5.LoggerFactory>(() => _i5.LoggerFactory());
  gh.singleton<_i6.NetworkLogsRepositoryType>(_i7.NetworkLogsRepository());
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i9.ChangelogService>(
      () => _i9.ChangelogService(gh<_i8.SharedPreferences>()));
  await gh.lazySingletonAsync<_i10.DeviceInfo>(
    () => _i10.DeviceInfo.create(gh<_i4.DeviceInfoPlugin>()),
    preResolve: true,
  );
  gh.lazySingleton<_i11.ReviewService>(
      () => _i11.ReviewService(gh<_i8.SharedPreferences>()));
  gh.lazySingleton<_i12.SettingsRepository>(
      () => _i12.SettingsRepository(gh<_i8.SharedPreferences>()));
  gh.factory<_i13.UpnpDiscovery>(() => registerModule.upnp(
        gh<_i10.DeviceInfo>(),
        gh<_i12.SettingsRepository>(),
      ));
  gh.lazySingleton<_i14.ApplicationBloc>(
      () => _i14.ApplicationBloc(gh<_i11.ReviewService>()));
  return getIt;
}

class _$RegisterModule extends _i15.RegisterModule {}
