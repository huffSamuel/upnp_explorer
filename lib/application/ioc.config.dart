// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../domain/device/device_repository_type.dart' as _i5;
import '../domain/device/service_repository_type.dart' as _i10;
import '../domain/network_logs/network_logs_repository_type.dart' as _i8;
import '../infrastructure/core/bug_report_service.dart' as _i3;
import '../infrastructure/core/download_service.dart' as _i16;
import '../infrastructure/upnp/device_discovery_service.dart' as _i22;
import '../infrastructure/upnp/search_request_builder.dart' as _i13;
import '../infrastructure/upnp/soap_service.dart' as _i19;
import '../infrastructure/upnp/ssdp_discovery.dart' as _i23;
import '../presentation/core/bloc/application_bloc.dart' as _i20;
import '../presentation/device/bloc/discovery_bloc.dart' as _i24;
import '../presentation/service/bloc/command_bloc.dart' as _i21;
import 'changelog/changelog_service.dart' as _i14;
import 'device.dart' as _i15;
import 'device/device_repository.dart' as _i6;
import 'device/service_repository.dart' as _i11;
import 'ioc.dart' as _i25;
import 'logger_factory.dart' as _i7;
import 'network_logs/network_logs_repository.dart' as _i9;
import 'review/review_service.dart' as _i17;
import 'settings/options_repository.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.singleton<_i5.DeviceRepositoryType>(
    _i6.DeviceRepository(),
    instanceName: 'DeviceRepository',
  );
  gh.singleton<_i7.LoggerFactory>(_i7.LoggerFactory());
  gh.singleton<_i8.NetworkLogsRepositoryType>(_i9.NetworkLogsRepository());
  gh.singleton<_i10.ServiceRepositoryType>(
    _i11.ServiceRepository(),
    instanceName: 'ServiceRepository',
  );
  await gh.factoryAsync<_i12.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  await gh.factoryAsync<_i13.UserAgentBuilder>(
    () => registerModule.userAgentBuilder,
    preResolve: true,
  );
  gh.singleton<_i14.ChangelogService>(
      _i14.ChangelogService(get<_i12.SharedPreferences>()));
  gh.singletonAsync<_i15.DeviceInfo>(
      () => _i15.DeviceInfo.create(get<_i4.DeviceInfoPlugin>()));
  gh.singleton<_i16.DownloadService>(
      _i16.DownloadService(get<_i7.LoggerFactory>()));
  gh.singleton<_i17.ReviewService>(
      _i17.ReviewService(get<_i12.SharedPreferences>()));
  gh.singleton<_i13.SearchRequestBuilder>(
      _i13.SearchRequestBuilder(get<_i13.UserAgentBuilder>()));
  gh.singleton<_i18.SettingsRepository>(
      _i18.SettingsRepository(get<_i12.SharedPreferences>()));
  gh.singleton<_i19.SoapService>(_i19.SoapService(
    get<_i13.UserAgentBuilder>(),
    get<_i8.NetworkLogsRepositoryType>(),
  ));
  gh.singleton<_i20.ApplicationBloc>(
      _i20.ApplicationBloc(get<_i17.ReviewService>()));
  gh.singleton<_i21.CommandBloc>(_i21.CommandBloc(get<_i19.SoapService>()));
  gh.singleton<_i22.DeviceDiscoveryService>(_i22.DeviceDiscoveryService(
    get<_i7.LoggerFactory>(),
    get<_i8.NetworkLogsRepositoryType>(),
    get<_i13.SearchRequestBuilder>(),
  ));
  gh.singleton<_i23.SSDPService>(_i23.SSDPService(
    get<_i22.DeviceDiscoveryService>(),
    get<_i16.DownloadService>(),
    get<_i7.LoggerFactory>(),
    get<_i5.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
    get<_i10.ServiceRepositoryType>(instanceName: 'ServiceRepository'),
    get<_i8.NetworkLogsRepositoryType>(),
  ));
  gh.singleton<_i24.DiscoveryBloc>(_i24.DiscoveryBloc(get<_i23.SSDPService>()));
  return get;
}

class _$RegisterModule extends _i25.RegisterModule {}
