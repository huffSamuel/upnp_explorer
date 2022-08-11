// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../domain/device/device_repository_type.dart' as _i4;
import '../domain/device/service_repository_type.dart' as _i7;
import '../infrastructure/core/bug_report_service.dart' as _i3;
import '../infrastructure/core/download_service.dart' as _i11;
import '../infrastructure/core/logger_factory.dart' as _i6;
import '../infrastructure/settings/options_repository.dart' as _i13;
import '../infrastructure/ssdp/device_discovery_service.dart' as _i10;
import '../infrastructure/ssdp/ssdp_discovery.dart' as _i12;
import '../presentation/device/bloc/discovery_bloc.dart' as _i14;
import 'device/device_repository.dart' as _i5;
import 'device/service_repository.dart' as _i8;
import 'ioc.dart' as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initIoc(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.BugReportService>(_i3.BugReportService());
  gh.singleton<_i4.DeviceRepositoryType>(_i5.DeviceRepository(),
      instanceName: 'DeviceRepository');
  gh.singleton<_i6.LoggerFactory>(_i6.LoggerFactory());
  gh.singleton<_i7.ServiceRepositoryType>(_i8.ServiceRepository(),
      instanceName: 'ServiceRepository');
  await gh.factoryAsync<_i9.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.singleton<_i10.DeviceDiscoveryService>(
      _i10.DeviceDiscoveryService(get<_i6.LoggerFactory>()));
  gh.singleton<_i11.DownloadService>(
      _i11.DownloadService(get<_i6.LoggerFactory>()));
  gh.singleton<_i12.SSDPService>(_i12.SSDPService(
      get<_i10.DeviceDiscoveryService>(),
      get<_i11.DownloadService>(),
      get<_i6.LoggerFactory>(),
      get<_i4.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
      get<_i7.ServiceRepositoryType>(instanceName: 'ServiceRepository')));
  gh.singleton<_i13.SettingsRepository>(
      _i13.SettingsRepository(get<_i9.SharedPreferences>()));
  gh.singleton<_i14.DiscoveryBloc>(_i14.DiscoveryBloc(get<_i12.SSDPService>()));
  return get;
}

class _$RegisterModule extends _i15.RegisterModule {}
