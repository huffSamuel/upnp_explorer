import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String lastChangelogVersion = 'lastChangelogVersion';

@lazySingleton
class ChangelogService {
  final SharedPreferences prefs;

  ChangelogService(this.prefs);

  Future<bool> shouldDisplayChangelog() async {
    final lastDisplayed = prefs.getString(lastChangelogVersion);
    final currentVersion = (await PackageInfo.fromPlatform()).version;

    if (lastDisplayed != currentVersion) {
      await prefs.setString(lastChangelogVersion, currentVersion);
      return true;
    }

    return false;
  }

  Future<String> changes() async {
    return rootBundle.loadString('assets/CHANGELOG.md');
  }
}
