// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../domain/device/device_repository_type.dart' as _i4;
import '../domain/device/service_repository_type.dart' as _i8;
import '../infrastructure/core/bug_report_service.dart' as _i3;
import '../infrastructure/core/download_service.dart' as _i14;
import '../infrastructure/core/logger_factory.dart' as _i6;
import '../infrastructure/settings/options_repository.dart' as _i17;
import '../infrastructure/upnp/device_discovery_service.dart' as _i13;
import '../infrastructure/upnp/search_request_builder.dart' as _i7;
import '../infrastructure/upnp/ssdp_discovery.dart' as _i16;
import '../presentation/core/bloc/application_bloc.dart' as _i18;
import '../presentation/device/bloc/discovery_bloc.dart' as _i19;
import 'changelog/changelog_service.dart' as _i12;
import 'device/device_repository.dart' as _i5;
import 'device/service_repository.dart' as _i9;
import 'network_logs/traffic_repository.dart' as _i11;
import 'ioc.dart' as _i20;
import 'review/review_service.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

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
  await gh.factoryAsync<_i7.SearchRequestBuilder>(
    () => registerModule.searchRequestBuilder,
    preResolve: true,
  );
  gh.singleton<_i8.ServiceRepositoryType>(
    _i9.ServiceRepository(),
    instanceName: 'ServiceRepository',
  );
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i11.NetworkLogsRepository>(_i11.NetworkLogsRepository());
  gh.singleton<_i12.ChangelogService>(
      _i12.ChangelogService(get<_i10.SharedPreferences>()));
  gh.singleton<_i13.DeviceDiscoveryService>(_i13.DeviceDiscoveryService(
    get<_i6.LoggerFactory>(),
    get<_i11.NetworkLogsRepository>(),
    get<_i7.SearchRequestBuilder>(),
  ));
  gh.singleton<_i14.DownloadService>(
      _i14.DownloadService(get<_i6.LoggerFactory>()));
  gh.singleton<_i15.ReviewService>(
      _i15.ReviewService(get<_i10.SharedPreferences>()));
  gh.singleton<_i16.SSDPService>(_i16.SSDPService(
    get<_i13.DeviceDiscoveryService>(),
    get<_i14.DownloadService>(),
    get<_i6.LoggerFactory>(),
    get<_i4.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
    get<_i8.ServiceRepositoryType>(instanceName: 'ServiceRepository'),
    get<_i11.NetworkLogsRepository>(),
  ));
  gh.singleton<_i17.SettingsRepository>(
      _i17.SettingsRepository(get<_i10.SharedPreferences>()));
  gh.singleton<_i18.ApplicationBloc>(
      _i18.ApplicationBloc(get<_i15.ReviewService>()));
  gh.singleton<_i19.DiscoveryBloc>(_i19.DiscoveryBloc(get<_i16.SSDPService>()));
  return get;
}

class _$RegisterModule extends _i20.RegisterModule {}
