import 'package:injectable/injectable.dart';
import 'package:upnp_explorer/domain/device/service_repository_type.dart';
import 'package:upnp_explorer/infrastructure/upnp/service_description.dart';

@named
@Singleton(as: ServiceRepositoryType)
class ServiceRepository extends ServiceRepositoryType {
  Map<String, ServiceDescription> services = {};

  @override
  ServiceDescription? get(String id) {
    if(!services.containsKey(id)) {
      return null;
    }

    return services[id];
  }

  @override
  void insert(String id, ServiceDescription service) {
    services[id] = service;
  }

}