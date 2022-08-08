import 'package:fluro/fluro.dart';

import '../../domain/device/service_repository_type.dart';
import '../../infrastructure/upnp/device.dart';
import '../../presentation/device/pages/device_document_page.dart';
import '../../presentation/device/pages/device_list_page.dart';
import '../../presentation/device/pages/discovery-page.dart';
import '../../presentation/device/pages/service_list_page.dart';
import '../../presentation/device/pages/service_page.dart';
import '../ioc.dart';

var rootHandler = Handler(handlerFunc: (context, _) => DiscoveryPage());

var deviceHandler = Handler(handlerFunc: (context, params) {
  final args = context!.settings!.arguments as Device;

  return DeviceDocumentPage(device: args);
});

var serviceListHandler = Handler(handlerFunc: (context, _) {
  final args = context!.settings!.arguments as ServiceList;

  return ServiceListPage(services: args);
});

var deviceListHandler = Handler(handlerFunc: (context, _) {
  final args = context!.settings!.arguments as DeviceList;

  return DeviceListPage(devices: args);
});

var serviceHandler = Handler(handlerFunc: (context, params) {
  final id = params['id']![0];

  final repo = sl.get<ServiceRepositoryType>(instanceName: 'ServiceRepository');

  return ServicePage(
    description: repo.get(id)!,
    service: context!.settings!.arguments as Service,
  );
});
