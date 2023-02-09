import '../../infrastructure/upnp/models/service_description.dart';

abstract class ServiceDescriptionRepository {
  ServiceDescription? get(String deviceId, String id);
  bool has(String deviceId, String id);
  void insert(String deviceId, String id, ServiceDescription service);
}
