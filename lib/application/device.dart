import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

const minimumMaterialYouSdkVersion = 31;

@lazySingleton
class DeviceInfo {
  final String os;
  final String osVersion;
  final String packageName;
  final String packageVersion;
  final int? androidSdkVersion;
  
  DeviceInfo(
    this.os,
    this.osVersion,
    this.packageName,
    this.packageVersion, {
    this.androidSdkVersion,
  });

  @preResolve
  @factoryMethod
  static Future<DeviceInfo> create(DeviceInfoPlugin plugin) async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      return DeviceInfo(
        'Android',
        info.version.sdkInt.toString(),
        packageInfo.appName,
        packageInfo.version,
        androidSdkVersion: info.version.sdkInt,
      );
    }

    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      return DeviceInfo('iOS', info.systemVersion!, packageInfo.appName,
          packageInfo.version);
    }

    throw PlatformNotSupported();
  }
}

class PlatformNotSupported {}
