import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Environment(Environment.prod)
@singleton
class VersionService {
  String? _version;

  Future<String> getVersion() async {
    return _version ??= (await (PackageInfo.fromPlatform())).version;
  }
}
