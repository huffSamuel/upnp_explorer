import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluro/fluro.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Application {
  static FluroRouter? router;
  static const submitBugUrl =
      'https://github.com/huffSamuel/upnp_explorer_issues/issues/new/choose';
  static const name = 'UPnP Scanner';
  static const privacyPolicyUrl =
      'https://github.com/huffSamuel/upnp_explorer_issues/blob/main/PRIVACY_POLICY.md';
  static const appId = 'com.samueljhuf.upnp_explorer';
}
