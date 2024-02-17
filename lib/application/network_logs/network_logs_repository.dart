import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:upnp_explorer/simple_upnp/src/upnp.dart';

import '../../domain/network_logs/network_logs_repository_type.dart';

@Singleton(as: NetworkLogsRepositoryType)
class NetworkLogsRepository extends NetworkLogsRepositoryType {
  ReplaySubject<UPnPEvent> _subject = ReplaySubject<UPnPEvent>();

  NetworkLogsRepository() {
    SimpleUPNP.instance().events.listen((event) {
      _subject.add(event);
    });
  }

  Stream<UPnPEvent> get messages {
    return _subject.stream;
  }

  void clear() {
    _subject.close();
    _subject = ReplaySubject<UPnPEvent>();
  }
}
