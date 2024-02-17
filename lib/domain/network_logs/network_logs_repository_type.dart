import 'package:upnp_explorer/simple_upnp/src/upnp.dart';

abstract class NetworkLogsRepositoryType {
  Stream<UPnPEvent> get messages;
  void clear();
}
