import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/options_repository.dart';
import '../../presentation/device/bloc/discovery_bloc.dart';
import 'bug_report_service.dart';
import 'device_data_service.dart';
import 'device_discovery_service.dart';
import 'logging/logger_factory.dart';
import 'ssdp_discovery.dart';

final sl = GetIt.instance;

Future initializeService() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerSingleton(prefs)
    ..registerSingleton(OptionsRepository(sl()))
    ..registerLazySingleton(() => LoggerFactory())
    ..registerLazySingleton(() => DeviceDataService(sl()))
    ..registerLazySingleton(() => DeviceDiscoveryService(sl()))
    ..registerLazySingleton(() => SSDPService(sl(), sl(), sl()))
    ..registerLazySingleton(() => BugReportService())
    ..registerLazySingleton(() => DiscoveryBloc(sl()));
}
