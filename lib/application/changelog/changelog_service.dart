import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:upnp_explorer/application/application.dart';

const String lastChangelogVersion = 'lastChangelogVersion';

@lazySingleton
class ChangelogService {
  final SharedPreferences prefs;

  ChangelogService(this.prefs);

  Future<String> version() async => (await PackageInfo.fromPlatform()).version;

  Future<bool> shouldDisplayChangelog() async {
    final lastDisplayed = prefs.getString(lastChangelogVersion);
    final currentVersion = await version();

    if (lastDisplayed != currentVersion) {
      await prefs.setString(lastChangelogVersion, currentVersion);
      return true;
    }

    return false;
  }

  Stream<String> changes() => Stream.fromFuture(futureChanges());

  Future<String> futureChanges() async {
    final currentVersion = await version();

    final uri =
        'https://raw.githubusercontent.com/huffSamuel/upnp_explorer/v$currentVersion/CHANGELOG.md';

    final data = await http.get(Uri.parse(uri));
    return data.body
        .split(Platform.lineTerminator)
        .skipWhile((x) => !x.startsWith('##'))
        .join(Platform.lineTerminator);
  }
}
