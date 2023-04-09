import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:upnp_explorer/domain/upnp/upnp.dart';

import '../../domain/network_logs/network_logs_repository_type.dart';

@Singleton(as: NetworkLogsRepositoryType)
class NetworkLogsRepository extends NetworkLogsRepositoryType {
  ReplaySubject<NetworkMessage> _subject = ReplaySubject<NetworkMessage>();

  NetworkLogsRepository() {
    messageEvents.listen((event) {
      _subject.add(event);
    });
  }

  Stream<NetworkMessage> get messages {
    return _subject.stream;
  }

  void clear() {
    _subject.close();
    _subject = ReplaySubject<NetworkMessage>();
  }
}
