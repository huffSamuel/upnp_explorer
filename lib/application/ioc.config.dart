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
import '../infrastructure/core/download_service.dart' as _i13;
import 'logger_factory.dart' as _i6;
import 'settings/options_repository.dart' as _i15;
import '../infrastructure/upnp/device_discovery_service.dart' as _i19;
import '../infrastructure/upnp/search_request_builder.dart' as _i11;
import '../infrastructure/upnp/soap_service.dart' as _i16;
import '../infrastructure/upnp/ssdp_discovery.dart' as _i20;
import '../presentation/core/bloc/application_bloc.dart' as _i17;
import '../presentation/device/bloc/discovery_bloc.dart' as _i21;
import '../presentation/service/bloc/command_bloc.dart' as _i18;
import 'changelog/changelog_service.dart' as _i12;
import 'device/device_repository.dart' as _i5;
import 'device/service_repository.dart' as _i9;
import 'ioc.dart' as _i22;
import 'network_logs/network_logs_repository.dart' as _i7;
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
  gh.singleton<_i7.NetworkLogsRepository>(_i7.NetworkLogsRepository());
  gh.singleton<_i8.ServiceRepositoryType>(
    _i9.ServiceRepository(),
    instanceName: 'ServiceRepository',
  );
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  await gh.factoryAsync<_i11.UserAgentBuilder>(
    () => registerModule.userAgentBuilder,
    preResolve: true,
  );
  gh.singleton<_i12.ChangelogService>(
      _i12.ChangelogService(get<_i10.SharedPreferences>()));
  gh.singleton<_i13.DownloadService>(
      _i13.DownloadService(get<_i6.LoggerFactory>()));
  gh.singleton<_i14.ReviewService>(
      _i14.ReviewService(get<_i10.SharedPreferences>()));
  gh.singleton<_i11.SearchRequestBuilder>(
      _i11.SearchRequestBuilder(get<_i11.UserAgentBuilder>()));
  gh.singleton<_i15.SettingsRepository>(
      _i15.SettingsRepository(get<_i10.SharedPreferences>()));
  gh.singleton<_i16.SoapService>(_i16.SoapService(
    get<_i11.UserAgentBuilder>(),
    get<_i7.NetworkLogsRepository>(),
  ));
  gh.singleton<_i17.ApplicationBloc>(
      _i17.ApplicationBloc(get<_i14.ReviewService>()));
  gh.singleton<_i18.CommandBloc>(_i18.CommandBloc(get<_i16.SoapService>()));
  gh.singleton<_i19.DeviceDiscoveryService>(_i19.DeviceDiscoveryService(
    get<_i6.LoggerFactory>(),
    get<_i7.NetworkLogsRepository>(),
    get<_i11.SearchRequestBuilder>(),
  ));
  gh.singleton<_i20.SSDPService>(_i20.SSDPService(
    get<_i19.DeviceDiscoveryService>(),
    get<_i13.DownloadService>(),
    get<_i6.LoggerFactory>(),
    get<_i4.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
    get<_i8.ServiceRepositoryType>(instanceName: 'ServiceRepository'),
    get<_i7.NetworkLogsRepository>(),
  ));
  gh.singleton<_i21.DiscoveryBloc>(_i21.DiscoveryBloc(get<_i20.SSDPService>()));
  return get;
}

class _$RegisterModule extends _i22.RegisterModule {}
