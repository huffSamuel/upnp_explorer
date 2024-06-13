// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      themeMode: json['themeMode'] == null
          ? ThemeMode.system
          : _themeModeFromJson(json['themeMode'] as String),
      density: json['visualDensity'] == null
          ? Density.standard
          : _densityFromJson(json['visualDensity'] as String),
      protocolOptions: json['protocol'] == null
          ? _defaultProtocolSettings
          : ProtocolSettings.fromJson(json['protocol'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'themeMode': _themeModeToJson(instance.themeMode),
      'visualDensity': _densityToJson(instance.density),
      'protocol': instance.protocolOptions,
    };
