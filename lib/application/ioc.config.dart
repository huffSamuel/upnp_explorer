// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../domain/device/device_repository_type.dart' as _i4;
import '../domain/device/service_repository_type.dart' as _i7;
import '../infrastructure/core/bug_report_service.dart' as _i3;
import '../infrastructure/core/download_service.dart' as _i13;
import '../infrastructure/core/logger_factory.dart' as _i6;
import '../infrastructure/settings/options_repository.dart' as _i16;
import '../infrastructure/ssdp/device_discovery_service.dart' as _i12;
import '../infrastructure/ssdp/ssdp_discovery.dart' as _i15;
import '../presentation/core/bloc/application_bloc.dart' as _i17;
import '../presentation/device/bloc/discovery_bloc.dart' as _i18;
import 'changelog/changelog_service.dart' as _i11;
import 'device/device_repository.dart' as _i5;
import 'device/service_repository.dart' as _i8;
import 'device/traffic_repository.dart' as _i10;
import 'ioc.dart' as _i19;
import 'review/review_service.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initIoc(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.BugReportService>(_i3.BugReportService());
  gh.singleton<_i4.DeviceRepositoryType>(
    _i5.DeviceRepository(),
    instanceName: 'DeviceRepository',
  );
  gh.singleton<_i6.LoggerFactory>(_i6.LoggerFactory());
  gh.singleton<_i7.ServiceRepositoryType>(
    _i8.ServiceRepository(),
    instanceName: 'ServiceRepository',
  );
  await gh.factoryAsync<_i9.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i10.TrafficRepository>(_i10.TrafficRepository());
  gh.singleton<_i11.ChangelogService>(
      _i11.ChangelogService(get<_i9.SharedPreferences>()));
  gh.singleton<_i12.DeviceDiscoveryService>(_i12.DeviceDiscoveryService(
    get<_i6.LoggerFactory>(),
    get<_i10.TrafficRepository>(),
  ));
  gh.singleton<_i13.DownloadService>(
      _i13.DownloadService(get<_i6.LoggerFactory>()));
  gh.singleton<_i14.ReviewService>(
      _i14.ReviewService(get<_i9.SharedPreferences>()));
  gh.singleton<_i15.SSDPService>(_i15.SSDPService(
    get<_i12.DeviceDiscoveryService>(),
    get<_i13.DownloadService>(),
    get<_i6.LoggerFactory>(),
    get<_i4.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
    get<_i7.ServiceRepositoryType>(instanceName: 'ServiceRepository'),
    get<_i10.TrafficRepository>(),
  ));
  gh.singleton<_i16.SettingsRepository>(
      _i16.SettingsRepository(get<_i9.SharedPreferences>()));
  gh.singleton<_i17.ApplicationBloc>(
      _i17.ApplicationBloc(get<_i14.ReviewService>()));
  gh.singleton<_i18.DiscoveryBloc>(_i18.DiscoveryBloc(get<_i15.SSDPService>()));
  return get;
}

class _$RegisterModule extends _i19.RegisterModule {}
