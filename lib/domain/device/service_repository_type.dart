import 'package:upnp_explorer/infrastructure/upnp/service_description.dart';

abstract class ServiceRepositoryType {
  ServiceDescription? get(String id);
  void insert(String id, ServiceDescription service);
}
