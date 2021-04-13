import 'package:flutter/material.dart';

class AppSettingsDataSource {}

class AppSettingsRepository {}

class GetAppSettings {}

class SetAppSettings {}

class AppSettings {
  final ThemeMode themeMode;
  final DisplayDensity density;

  AppSettings(this.themeMode, this.density);
}

enum DisplayDensity {
  comfortable,
  cozy,
  compact,
}
