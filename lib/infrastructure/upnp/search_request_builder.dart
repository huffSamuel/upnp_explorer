import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'm_search_request.dart';

import 'models/search_target.dart';

class SearchRequestBuilder {
  late PackageInfo packageInfo;

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;

  String os = Platform.operatingSystem;

  static Future<SearchRequestBuilder> create() async {
    final builder = SearchRequestBuilder();

    await builder.init();

    return builder;
  }

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
    final plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      androidInfo = await plugin.androidInfo;
      print(androidInfo?.toMap());
    } else if (Platform.isIOS) {
      iosInfo = await plugin.iosInfo;
    }
  }

  MSearchRequest build({
    SearchTarget searchTarget = const SearchTarget.rootDevice(),
    required int maxResponseTime,
  }) {
    final packageName = packageInfo.packageName.split('.').last;

    return MSearchRequest(
      searchTarget: searchTarget,
      maxResponseTime: maxResponseTime,
      os: os,
      osVersion: androidInfo?.version.sdkInt.toString() ?? '1',
      packageName: packageName,
      packageVersion: packageInfo.version,
    );
  }
}
