// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../domain/device/device_repository_type.dart' as _i4;
import '../domain/device/service_repository_type.dart' as _i9;
import '../domain/network_logs/network_logs_repository_type.dart' as _i7;
import '../infrastructure/core/bug_report_service.dart' as _i3;
import '../infrastructure/core/download_service.dart' as _i14;
import '../infrastructure/upnp/device_discovery_service.dart' as _i20;
import '../infrastructure/upnp/search_request_builder.dart' as _i12;
import '../infrastructure/upnp/soap_service.dart' as _i17;
import '../infrastructure/upnp/ssdp_discovery.dart' as _i21;
import '../presentation/core/bloc/application_bloc.dart' as _i18;
import '../presentation/device/bloc/discovery_bloc.dart' as _i22;
import '../presentation/service/bloc/command_bloc.dart' as _i19;
import 'changelog/changelog_service.dart' as _i13;
import 'device/device_repository.dart' as _i5;
import 'device/service_repository.dart' as _i10;
import 'ioc.dart' as _i23;
import 'logger_factory.dart' as _i6;
import 'network_logs/network_logs_repository.dart' as _i8;
import 'review/review_service.dart' as _i15;
import 'settings/options_repository.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i7.NetworkLogsRepositoryType>(_i8.NetworkLogsRepository());
  gh.singleton<_i9.ServiceRepositoryType>(
    _i10.ServiceRepository(),
    instanceName: 'ServiceRepository',
  );
  await gh.factoryAsync<_i11.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  await gh.factoryAsync<_i12.UserAgentBuilder>(
    () => registerModule.userAgentBuilder,
    preResolve: true,
  );
  gh.singleton<_i13.ChangelogService>(
      _i13.ChangelogService(get<_i11.SharedPreferences>()));
  gh.singleton<_i14.DownloadService>(
      _i14.DownloadService(get<_i6.LoggerFactory>()));
  gh.singleton<_i15.ReviewService>(
      _i15.ReviewService(get<_i11.SharedPreferences>()));
  gh.singleton<_i12.SearchRequestBuilder>(
      _i12.SearchRequestBuilder(get<_i12.UserAgentBuilder>()));
  gh.singleton<_i16.SettingsRepository>(
      _i16.SettingsRepository(get<_i11.SharedPreferences>()));
  gh.singleton<_i17.SoapService>(_i17.SoapService(
    get<_i12.UserAgentBuilder>(),
    get<_i7.NetworkLogsRepositoryType>(),
  ));
  gh.singleton<_i18.ApplicationBloc>(
      _i18.ApplicationBloc(get<_i15.ReviewService>()));
  gh.singleton<_i19.CommandBloc>(_i19.CommandBloc(get<_i17.SoapService>()));
  gh.singleton<_i20.DeviceDiscoveryService>(_i20.DeviceDiscoveryService(
    get<_i6.LoggerFactory>(),
    get<_i7.NetworkLogsRepositoryType>(),
    get<_i12.SearchRequestBuilder>(),
  ));
  gh.singleton<_i21.SSDPService>(_i21.SSDPService(
    get<_i20.DeviceDiscoveryService>(),
    get<_i14.DownloadService>(),
    get<_i6.LoggerFactory>(),
    get<_i4.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
    get<_i9.ServiceRepositoryType>(instanceName: 'ServiceRepository'),
    get<_i7.NetworkLogsRepositoryType>(),
  ));
  gh.singleton<_i22.DiscoveryBloc>(_i22.DiscoveryBloc(get<_i21.SSDPService>()));
  return get;
}

class _$RegisterModule extends _i23.RegisterModule {}
