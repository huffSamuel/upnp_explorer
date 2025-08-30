import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../application.dart';
import '../version_service.dart';

const String lastChangelogVersion = 'lastChangelogVersion';

@Environment(Environment.prod)
@lazySingleton
class ChangelogService {
  final SharedPreferences prefs;
  final VersionService versionService;
  String? _changes;

  ChangelogService(this.prefs, this.versionService);

  Future<bool> shouldDisplayChangelog() async {
    final lastDisplayed = prefs.getString(lastChangelogVersion);
    final currentVersion = await versionService.getVersion();

    if (lastDisplayed != currentVersion) {
      await prefs.setString(lastChangelogVersion, currentVersion);
      return true;
    }

    return false;
  }

  Stream<String> changes() => Stream.fromFuture(futureChanges());

  Future<String> futureChanges() async {
    if (_changes == null) {
      final currentVersion = await await versionService.getVersion();

      final uri =
          '${GitHub.baseContentUrl}/huffSamuel/upnp_explorer/v$currentVersion/CHANGELOG.md';

      final data = await http.get(Uri.parse(uri));

      if (data.statusCode < 200 || data.statusCode > 299) {
        throw LoadFailedException();
      }

      _changes = data.body
          .split(Platform.lineTerminator)
          .skipWhile((x) => !x.startsWith('##'))
          .join(Platform.lineTerminator);
    }

    return _changes!;
  }
}

class LoadFailedException extends Error {}
