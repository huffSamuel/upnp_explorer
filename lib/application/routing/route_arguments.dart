import '../../infrastructure/upnp/models/device.dart';

class ServiceListPageRouteArgs {
  final ServiceList serviceList;
  final String deviceId;

  ServiceListPageRouteArgs(this.serviceList, this.deviceId);
}

class ServicePageRouteArgs {
  final Service service;
  final String deviceId;

  ServicePageRouteArgs(this.service, this.deviceId);
}