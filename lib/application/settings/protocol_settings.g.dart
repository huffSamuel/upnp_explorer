// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProtocolSettings _$ProtocolSettingsFromJson(Map<String, dynamic> json) =>
    ProtocolSettings(
      maxDelay: (json['maxDelay'] as num?)?.toInt() ?? 5,
      advanced: json['advanced'] as bool? ?? false,
      hops: (json['hops'] as num?)?.toInt() ?? 1,
      searchTarget: json['searchTarget'] as String? ?? 'upnp:rootdevice',
    );

Map<String, dynamic> _$ProtocolSettingsToJson(ProtocolSettings instance) =>
    <String, dynamic>{
      'maxDelay': instance.maxDelay,
      'advanced': instance.advanced,
      'hops': instance.hops,
      'searchTarget': instance.searchTarget,
    };
