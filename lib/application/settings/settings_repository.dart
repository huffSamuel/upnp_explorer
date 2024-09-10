import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/value_converter.dart';
import 'settings.dart';

const _kSettings = 'settings';
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
const legacyKeys = [
  _kThemeKey,
  _kVisualDensityHorizontal,
  _kVisualDensityVertical,
  _kMaxDelay,
  _kHops,
  _kAdvanced,
  _searchTargetKey
];

@lazySingleton
class SettingsRepository {
  final SharedPreferences preferences;

  SettingsRepository(this.preferences);

  Future<void> set(Settings options) async {
    await preferences.setString(_kSettings, json.encode(options.toJson()));
  }

  Future<Settings> _migrateSettingsStorage() async {
    var settings = Settings();

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

      settings = settings.copyWith(
        themeMode: theme,
        density: density == null
            ? Density.standard
            : kVisualDensityConverter.from(density),
        protocolOptions: settings.protocolOptions.copyWith(
          advanced: advanced,
          hops: hops,
          maxDelay: delay,
          searchTarget: searchTarget,
        ),
      );
    } catch (err) {
      // Something bad happened but we don't really care.
    }

    await Future.wait([
      ...legacyKeys.map((x) => preferences.remove(x)),
      set(settings),
    ]);

    return settings;
  }

  Future<Settings> get() async {
    final jsonValue = preferences.getString(_kSettings);

    if (jsonValue == null || jsonValue.isEmpty == true) {
      return await _migrateSettingsStorage();
    }

    return Settings.fromJson(jsonDecode(jsonValue));
  }
}
