import 'package:injectable/injectable.dart';

import '../../domain/device/service_repository_type.dart';
import '../../infrastructure/upnp/models/service_description.dart';

@Singleton(as: ServiceDescriptionRepository)
class InMemoryServiceDescriptionRepository extends ServiceDescriptionRepository {
  Map<String, ServiceDescription> services = {};
  @override
  ServiceDescription? get(String deviceId, String id) {
    if (!services.containsKey(id)) {
      return null;
    }

    return services[id];
  }

  @override
  bool has(String deviceId, String id) {
    return services.containsKey(id);
  }

  @override
  void insert(String deviceId, String id, ServiceDescription service) {
    services[id] = service;
  }
}
