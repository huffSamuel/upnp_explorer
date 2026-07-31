import 'package:injectable/injectable.dart';

import '../version.dart';

@Environment(Environment.prod)
@singleton
class VersionService {
  String? _version;

  Future<String> getVersion() async {
    return _version ??= version;
  }
}
