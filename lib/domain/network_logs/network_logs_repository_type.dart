import 'package:upnp_explorer/domain/upnp/upnp.dart';

abstract class NetworkLogsRepositoryType {
  Stream<NetworkMessage> get messages;
  void clear();
}
