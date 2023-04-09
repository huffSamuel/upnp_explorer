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
  ThemeMode.dark: 'DARK',
  ThemeMode.system: 'SYSTEM',
  ThemeMode.light: 'LIGHT'
};
@lazySingleton
class SettingsRepository {
  final SharedPreferences prefs;

  SettingsRepository(this.prefs);

  set(Settings options) async {
    await Future.wait([
      prefs.setString(
        _kThemeKey,
        options.themeMode.name,
      ),
      prefs.setDouble(
        _kVisualDensityHorizontal,
        options.visualDensity.horizontal,
      ),
      prefs.setDouble(
        _kVisualDensityVertical,
        options.visualDensity.vertical,
      ),
      prefs.setInt(
        _kMaxDelay,
        options.protocolOptions.maxDelay,
      ),
      prefs.setInt(
        _kHops,
        options.protocolOptions.hops,
      ),
      prefs.setBool(
        _kAdvanced,
        options.protocolOptions.advanced,
      ),
    ]);
  }

  Settings get() {
    try {
      final themeValue = prefs.getString(_kThemeKey);
      final theme = keyFromValue(_kThemeMap, themeValue);
      final horizontal = prefs.getDouble(_kVisualDensityHorizontal);
      final vertical = prefs.getDouble(_kVisualDensityVertical);
      final delay = prefs.getInt(_kMaxDelay);
      final hops = prefs.getInt(_kHops);
      final advanced = prefs.getBool(_kAdvanced);
      final searchTarget = prefs.getString(_searchTargetKey);

      if ([
        theme,
        horizontal,
        vertical,
        delay,
        hops,
        advanced,
      ].any((x) => x == null)) {
        return Settings.base();
      }

      return Settings(
        themeMode: theme!,
        visualDensity: VisualDensity(
          horizontal: horizontal!,
          vertical: vertical!,
        ),
        protocolOptions: ProtocolSettings(
          advanced: advanced!,
          maxDelay: delay!,
          hops: hops!,
          searchTarget: searchTarget ?? 'upnp:rootdevice',
        ),
      );
    } catch (err) {
      return Settings.base();
    }
  }
}
