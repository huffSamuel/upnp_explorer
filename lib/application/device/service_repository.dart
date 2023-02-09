import 'package:injectable/injectable.dart';

import '../../domain/device/service_repository_type.dart';
import '../../infrastructure/upnp/models/service_description.dart';

@Singleton(as: ServiceDescriptionRepository)
class InMemoryServiceDescriptionRepository extends ServiceDescriptionRepository {
  Map<String, ServiceDescription> services = {};
  @override
  ServiceDescription? get(String deviceId, String id) {
    if (!services.containsKey(_key(deviceId, id))) {
      return null;
    }

    return services[_key(deviceId, id)];
  }

  @override
  bool has(String deviceId, String id) {
    return services.containsKey(_key(deviceId, id));
  }

  @override
  void insert(String deviceId, String id, ServiceDescription service) {
    services[_key(deviceId, id)] = service;
  }

  String _key(String deviceId, String id) {
    return '$deviceId:$id';
  }
}
