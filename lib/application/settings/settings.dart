import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'protocol_settings.dart';
import '../../domain/value_converter.dart';

import '../../presentation/core/widgets/model_binding.dart';

part 'settings.g.dart';

const _defaultVisualDensity = Density.standard;
const _defaultThemeMode = ThemeMode.system;
const _defaultProtocolSettings = ProtocolSettings();

ThemeMode _themeModeFromJson(String json) {
  for (final mode in ThemeMode.values) {
    if (mode.name == json) {
      return mode;
    }
  }

  return ThemeMode.system;
}

String _themeModeToJson(ThemeMode themeMode) {
  return themeMode.name;
}

Density _densityFromJson(String json) {
  for (final density in Density.values) {
    if (density.name == json) {
      return density;
    }
  }

  return Density.standard;
}

String _densityToJson(Density density) {
  return density.name;
}

@JsonSerializable()
class Settings {
  @JsonKey(
    name: 'themeMode',
    defaultValue: _defaultThemeMode,
    fromJson: _themeModeFromJson,
    toJson: _themeModeToJson,
  )
  final ThemeMode themeMode;

  @JsonKey(
    name: 'visualDensity',
    defaultValue: _defaultVisualDensity,
    fromJson: _densityFromJson,
    toJson: _densityToJson,
  )
  final Density density;

  VisualDensity get visualDensity => kVisualDensityConverter.to(density);

  @JsonKey(name: 'protocol')
  final ProtocolSettings protocolOptions;

  const Settings({
    this.themeMode = _defaultThemeMode,
    this.density = _defaultVisualDensity,
    this.protocolOptions = _defaultProtocolSettings,
  });

  Settings copyWith({
    ThemeMode? themeMode,
    Density? density,
    ProtocolSettings? protocolOptions,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      density: density ?? this.density,
      protocolOptions: protocolOptions ?? this.protocolOptions,
    );
  }

  static Settings of(BuildContext context) =>
      ModelBinding.of<Settings>(context);

  static void update(BuildContext context, Settings newModel) =>
      ModelBinding.update(context, newModel);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
