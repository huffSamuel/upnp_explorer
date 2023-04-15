import 'package:upnp_explorer/packages/upnp/upnp.dart';

abstract class NetworkLogsRepositoryType {
  Stream<NetworkMessage> get messages;
  void clear();
}
