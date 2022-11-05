import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'm_search_request.dart';

import 'models/search_target.dart';

class UserAgentBuilder {
  static Future<UserAgentBuilder> create() async {
    final builder = UserAgentBuilder();

    await builder.init();

    return builder;
  }

  late String packageVersion;
  late String packageName;
  late String osVersion;

  String os = Platform.operatingSystem;

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName.split('.').last;
    packageVersion = packageInfo.version;
    final plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await plugin.androidInfo;
      osVersion = androidInfo.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      final iosInfo = await plugin.iosInfo;
      osVersion = iosInfo.systemVersion!;
    }
  }

  String build({version = '1.1'}) {
    return '$os/$osVersion UPnP/$version $packageName/$packageVersion';
  }
}

@singleton
class SearchRequestBuilder {
  final UserAgentBuilder userAgent;

  SearchRequestBuilder(this.userAgent);

  MSearchRequest build({
    SearchTarget searchTarget = const SearchTarget.rootDevice(),
    required int maxResponseTime,
  }) {
    return MSearchRequest(
      searchTarget: searchTarget,
      maxResponseTime: maxResponseTime,
      userAgent: userAgent.build(version: '1.1'),
    );
  }
}
