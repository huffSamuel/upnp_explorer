import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../packages/github/contributor.dart';
import 'application.dart';
import 'version_service.dart';

const _contributorsCacheVersion = 'contributors_version';
const _contributors = 'contributors';

@lazySingleton
class ContributorsService {
  final SharedPreferences _prefs;
  final VersionService _versionService;


  ContributorsService(
      SharedPreferences preferences, VersionService versionService)
      : _prefs = preferences,
        _versionService = versionService;

  Future<Iterable<Contributor>> contributors() {
    return _load();
  }

  Future<Iterable<Contributor>> _load() async {
    final cacheVersion = _prefs.getString(_contributorsCacheVersion);
    final appVersion = await _versionService.getVersion();

    if (cacheVersion == appVersion) {
      return _mapContributors(_prefs.getString(_contributors)!);
    }

    try {
      final contributors = await _contributorsFromNetwork();
      await _updateCache(contributors, appVersion);

      return _mapContributors(contributors);
    } catch (_) {
      return _contributorsFromAssets();
    }
  }

  Future<Iterable<Contributor>> _contributorsFromAssets() async {
    final data = await rootBundle.loadString(Application.assets.contributors);

    return _mapContributors(data);
  }

  Future<String> _contributorsFromNetwork() async {
    final data = await http.get(Application.contributorUri);

    if (data.statusCode < 200 || data.statusCode > 299) {
      throw Exception("Failed to load contributors from network");
    }

    return data.body;
  }

  Iterable<Contributor> _mapContributors(String data) {
    final json = jsonDecode(data) as List<dynamic>;

    return json.map((e) => Contributor.fromJson(e as Map<String, dynamic>));
  }

  Future<void> _updateCache(String contributors, String appVersion) async {
    await _prefs.setString(_contributors, contributors);
    await _prefs.setString(_contributorsCacheVersion, appVersion);
  }
}
