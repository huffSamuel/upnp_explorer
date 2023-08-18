import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/value_converter.dart';
import 'options.dart';

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
@lazySingleton
class SettingsRepository {
  final SharedPreferences preferences;

  SettingsRepository(this.preferences);

  set(Settings options) async {
    await Future.wait([
      preferences.setString(
        _kThemeKey,
        options.themeMode.name,
      ),
      preferences.setDouble(
        _kVisualDensityHorizontal,
        options.visualDensity.horizontal,
      ),
      preferences.setDouble(
        _kVisualDensityVertical,
        options.visualDensity.vertical,
      ),
      preferences.setInt(
        _kMaxDelay,
        options.protocolOptions.maxDelay,
      ),
      preferences.setInt(
        _kHops,
        options.protocolOptions.hops,
      ),
      preferences.setBool(
        _kAdvanced,
        options.protocolOptions.advanced,
      ),
    ]);

    print('Set preferences');
  }

  Settings get() {
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

      var settings = Settings.base();

      print('Got settings\nTheme: $theme\nThemeValue: $themeValue');

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
      print('Failed to deserialize settings');
      return Settings.base();
    }
  }
}
