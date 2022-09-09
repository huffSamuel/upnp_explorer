import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/changelog/change_version.dart';

const String lastChangelogVersion = 'lastChangelogVersion';

@Singleton()
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

  Future<List<ChangeVersion>> changes() async {
    final json = await rootBundle.loadString('assets/changes.json');
    return (jsonDecode(json) as List<dynamic>)
        .map((x) => ChangeVersion.fromJson(x))
        .toList();
  }
}
