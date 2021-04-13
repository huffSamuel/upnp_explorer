import 'package:get_it/get_it.dart';

import 'device_discovery_service.dart';
import 'ssdp_discovery.dart';

final sl = GetIt.instance;

Future initializeService() async {
  sl
    ..registerLazySingleton(() => DeviceDataService())
    ..registerLazySingleton(() => DeviceDiscoveryService())
    ..registerLazySingleton(() => SSDPService(sl(), sl()));
}
