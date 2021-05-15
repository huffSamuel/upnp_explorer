import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/value_converter.dart';
import 'options.dart';

const _kThemeKey = 'ThemeMode';
const _kVisualDensityHorizontal = 'visualDensity_horizontal';
const _kVisualDensityVertical = 'visualDensity_vertical';
const _kMaxDelay = 'maxDelay';
const _kHops = 'hops';
const _kAdvanced = 'advanced';
const _kThemeMap = {
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
  ThemeMode.light: 'light'
};

class OptionsRepository {
  final SharedPreferences prefs;

  OptionsRepository(this.prefs);

  set(Options options) async {
    await Future.wait([
      prefs.setString(
        _kThemeKey,
        _kThemeMap[options.themeMode],
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

  Options get() {
    try {
      final theme = keyFromValue(_kThemeMap, prefs.getString(_kThemeKey));
      final horizontal = prefs.getDouble(_kVisualDensityHorizontal);
      final vertical = prefs.getDouble(_kVisualDensityVertical);
      final delay = prefs.getInt(_kMaxDelay);
      final hops = prefs.getInt(_kHops);
      final advanced = prefs.getBool(_kAdvanced);

      if ([theme, horizontal, vertical, delay, hops, advanced]
          .any((x) => x == null)) {
        return Options.base();
      }

      return Options(
        themeMode: theme,
        visualDensity: VisualDensity(
          horizontal: horizontal,
          vertical: vertical,
        ),
        protocolOptions: ProtocolOptions(
          advanced: advanced,
          maxDelay: delay,
          hops: hops,
        ),
      );
    } catch (err) {
      return Options.base();
    }
  }
}
