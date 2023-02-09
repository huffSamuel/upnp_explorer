// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;
import 'package:upnp_explorer/application/changelog/changelog_service.dart'
    as _i14;
import 'package:upnp_explorer/application/device.dart' as _i15;
import 'package:upnp_explorer/application/device/device_repository.dart' as _i6;
import 'package:upnp_explorer/application/device/service_repository.dart'
    as _i11;
import 'package:upnp_explorer/application/logger_factory.dart' as _i7;
import 'package:upnp_explorer/application/network_logs/network_logs_repository.dart'
    as _i9;
import 'package:upnp_explorer/application/review/review_service.dart' as _i17;
import 'package:upnp_explorer/application/settings/options_repository.dart'
    as _i18;
import 'package:upnp_explorer/domain/device/device_repository_type.dart' as _i5;
import 'package:upnp_explorer/domain/device/service_repository_type.dart'
    as _i10;
import 'package:upnp_explorer/domain/network_logs/network_logs_repository_type.dart'
    as _i8;
import 'package:upnp_explorer/infrastructure/core/bug_report_service.dart'
    as _i3;
import 'package:upnp_explorer/infrastructure/core/download_service.dart'
    as _i16;
import 'package:upnp_explorer/infrastructure/upnp/device_discovery_service.dart'
    as _i22;
import 'package:upnp_explorer/infrastructure/upnp/search_request_builder.dart'
    as _i13;
import 'package:upnp_explorer/infrastructure/upnp/soap_service.dart' as _i19;
import 'package:upnp_explorer/infrastructure/upnp/ssdp_discovery.dart' as _i23;
import 'package:upnp_explorer/presentation/core/bloc/application_bloc.dart'
    as _i20;
import 'package:upnp_explorer/presentation/device/bloc/discovery_bloc.dart'
    as _i24;
import 'package:upnp_explorer/presentation/service/bloc/command_bloc.dart'
    as _i21;

import 'ioc.dart' as _i25;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
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
  gh.singleton<_i3.BugReportService>(_i3.BugReportService());
  gh.factory<_i4.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.singleton<_i5.DeviceRepositoryType>(
    _i6.DeviceRepository(),
    instanceName: 'DeviceRepository',
  );
  gh.singleton<_i7.LoggerFactory>(_i7.LoggerFactory());
  gh.singleton<_i8.NetworkLogsRepositoryType>(_i9.NetworkLogsRepository());
  gh.singleton<_i10.ServiceDescriptionRepository>(
      _i11.InMemoryServiceDescriptionRepository());
  await gh.factoryAsync<_i12.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  await gh.factoryAsync<_i13.UserAgentBuilder>(
    () => registerModule.userAgentBuilder,
    preResolve: true,
  );
  gh.singleton<_i14.ChangelogService>(
      _i14.ChangelogService(gh<_i12.SharedPreferences>()));
  await gh.singletonAsync<_i15.DeviceInfo>(
    () => _i15.DeviceInfo.create(gh<_i4.DeviceInfoPlugin>()),
    preResolve: true,
  );
  gh.singleton<_i16.DownloadService>(
      _i16.DownloadService(gh<_i7.LoggerFactory>()));
  gh.singleton<_i17.ReviewService>(
      _i17.ReviewService(gh<_i12.SharedPreferences>()));
  gh.singleton<_i13.SearchRequestBuilder>(
      _i13.SearchRequestBuilder(gh<_i13.UserAgentBuilder>()));
  gh.singleton<_i18.SettingsRepository>(
      _i18.SettingsRepository(gh<_i12.SharedPreferences>()));
  gh.singleton<_i19.SoapService>(_i19.SoapService(
    gh<_i13.UserAgentBuilder>(),
    gh<_i8.NetworkLogsRepositoryType>(),
  ));
  gh.singleton<_i20.ApplicationBloc>(
      _i20.ApplicationBloc(gh<_i17.ReviewService>()));
  gh.singleton<_i21.CommandBloc>(_i21.CommandBloc(gh<_i19.SoapService>()));
  gh.singleton<_i22.DeviceDiscoveryService>(_i22.DeviceDiscoveryService(
    gh<_i7.LoggerFactory>(),
    gh<_i8.NetworkLogsRepositoryType>(),
    gh<_i13.SearchRequestBuilder>(),
  ));
  gh.singleton<_i23.SSDPService>(_i23.SSDPService(
    gh<_i22.DeviceDiscoveryService>(),
    gh<_i16.DownloadService>(),
    gh<_i7.LoggerFactory>(),
    gh<_i5.DeviceRepositoryType>(instanceName: 'DeviceRepository'),
    gh<_i10.ServiceDescriptionRepository>(),
    gh<_i8.NetworkLogsRepositoryType>(),
  ));
  gh.singleton<_i24.DiscoveryBloc>(_i24.DiscoveryBloc(gh<_i23.SSDPService>()));
  return getIt;
}

class _$RegisterModule extends _i25.RegisterModule {}
