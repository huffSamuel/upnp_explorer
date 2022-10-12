import '../../infrastructure/upnp/models/service_description.dart';

abstract class ServiceRepositoryType {
  ServiceDescription? get(String id);
  bool has(String id);
  void insert(String id, ServiceDescription service);
}
