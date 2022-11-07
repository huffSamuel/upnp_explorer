import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain/network_logs/network_logs_repository_type.dart';
import '../../domain/network_logs/traffic.dart';

@Singleton(as: NetworkLogsRepositoryType)
class NetworkLogsRepository extends NetworkLogsRepositoryType {
  final _controller = StreamController<Traffic>.broadcast();

  Stream<Traffic> get traffic => _controller.stream;

  List<Traffic> _traffic = [];

  List<Traffic> getAll() {
    return _traffic;
  }

  void clear() {
    _traffic.clear();
  }

  void add(Traffic item) {
    _traffic.add(item);
    _controller.add(item);
  }
}
