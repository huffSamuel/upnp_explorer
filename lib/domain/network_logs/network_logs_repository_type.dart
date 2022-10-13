import 'traffic.dart';

abstract class NetworkLogsRepositoryType {
  List<Traffic> getAll();
  void clear();
  void add(Traffic item);
}