import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

const minimumMaterialYouSdkVersion = 31;

@Singleton()
class DeviceInfo {
  final int sdkVersion;

  get supportsMaterial3 =>
      Platform.isAndroid && sdkVersion >= minimumMaterialYouSdkVersion;

  DeviceInfo(this.sdkVersion);

  @preResolve
  @factoryMethod
  static Future<DeviceInfo> create(DeviceInfoPlugin plugin) async {
    final info = await plugin.androidInfo;

    return DeviceInfo(info.version.sdkInt);
  }
}
