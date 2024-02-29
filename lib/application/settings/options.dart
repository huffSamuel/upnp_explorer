import 'package:flutter/material.dart';

import '../../domain/value_converter.dart';
import '../../presentation/core/widgets/model_binding.dart';
import 'protocol_settings.dart';

const _THEME_MODE = 'theme_mode';
const _PROTOCOL_SETTINGS = 'protocol_settings';
const _VISUAL_DENSITY = 'visual_density_n';

class Settings {
  final ThemeMode themeMode;
  final VisualDensity visualDensity;
  final ProtocolSettings protocolOptions;

  const Settings({
    ThemeMode? themeMode,
    VisualDensity? visualDensity,
    ProtocolSettings? protocolOptions,
  })  : themeMode = themeMode ?? ThemeMode.system,
        visualDensity = visualDensity ?? VisualDensity.standard,
        protocolOptions = protocolOptions ?? const ProtocolSettings();

  Settings copyWith({
    ThemeMode? themeMode,
    VisualDensity? visualDensity,
    ProtocolSettings? protocolOptions,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      visualDensity: visualDensity ?? this.visualDensity,
      protocolOptions: protocolOptions ?? this.protocolOptions,
    );
  }

  static Settings of(BuildContext context) =>
      ModelBinding.of<Settings>(context);

  static void update(BuildContext context, Settings newModel) =>
      ModelBinding.update(context, newModel);

  factory Settings.fromJson(Map<String, dynamic> json) {
    final visualDensityName = json[_VISUAL_DENSITY] as String?;
    final visualDensity = visualDensityName != null
        ? kVisualDensityConverter.to(
            Density.values.byName(visualDensityName),
          )
        : null;

    final themeModeName = json[_THEME_MODE] as String?;
    final themeMode = themeModeName != null ? ThemeMode.values.byName(themeModeName) : null;

    return Settings(
      visualDensity: visualDensity,
      themeMode: themeMode,
      protocolOptions: ProtocolSettings.fromJson(json[_PROTOCOL_SETTINGS]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _VISUAL_DENSITY: kVisualDensityConverter.from(visualDensity).name,
      _PROTOCOL_SETTINGS: protocolOptions.toJson(),
      _THEME_MODE: themeMode,
    };
  }
}
