import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/value_converter.dart';
import 'options.dart';

const _USER_SETTINGS = 'user_settings';
const _kThemeKey = 'ThemeMode';
const _kVisualDensityHorizontal = 'visualDensity_horizontal';
const _kVisualDensityVertical = 'visualDensity_vertical';
const _kMaxDelay = 'maxDelay';
const _kHops = 'hops';
const _kAdvanced = 'advanced';
const _searchTargetKey = 'search_target';
const _kThemeMap = {
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
  ThemeMode.light: 'light'
};

@Injectable()
class SettingsRepository {
  final SharedPreferences preferences;

  SettingsRepository(this.preferences);

  Settings? settings;

  Future<void> set(Settings options) async {
    settings = options;

    final json = options.toJson();
    final str = jsonEncode(json);

    return await preferences.setString(_USER_SETTINGS, str).then((_) => {});
  }

  Settings get() {
    return settings!;
  }

@PostConstruct(preResolve: true)
  Future<Settings> load() async {
    if (preferences.getString(_kThemeKey) != null) {
      settings = await _migrateStorage();
    } else {
      print('Get Options: Next');

      final str = preferences.getString(_USER_SETTINGS);

      settings = str == null ? Settings() : Settings.fromJson(jsonDecode(str));
    }

    return settings!;
  }

  Future<Settings> _migrateStorage() async {
    print('Get Options: Legacy');
    final settings = _getLegacy();
    await Future.wait([
      set(settings),
      ...[
        _kThemeKey,
        _kVisualDensityHorizontal,
        _kVisualDensityVertical,
        _kMaxDelay,
        _kHops,
        _kAdvanced,
        _searchTargetKey
      ].map((x) => preferences.remove(x))
    ]);

    return settings;
  }

  Settings _getLegacy() {
    try {
      final themeValue = preferences.getString(_kThemeKey);
      final theme = keyFromValue(_kThemeMap, themeValue);
      final horizontal = preferences.getDouble(_kVisualDensityHorizontal);
      final vertical = preferences.getDouble(_kVisualDensityVertical);
      final delay = preferences.getInt(_kMaxDelay);
      final hops = preferences.getInt(_kHops);
      final advanced = preferences.getBool(_kAdvanced);
      final searchTarget = preferences.getString(_searchTargetKey);

      VisualDensity? density;

      if (horizontal != null && vertical != null) {
        density = VisualDensity(vertical: vertical, horizontal: horizontal);
      }

      var settings = Settings();

      return settings.copyWith(
        themeMode: theme,
        visualDensity: density,
        protocolOptions: settings.protocolOptions.copyWith(
          advanced: advanced,
          hops: hops,
          maxDelay: delay,
          searchTarget: searchTarget,
        ),
      );
    } catch (err) {
      return Settings();
    }
  }
}
