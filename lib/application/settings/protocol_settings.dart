import 'package:json_annotation/json_annotation.dart';
import 'package:upnped/upnped.dart';

part 'protocol_settings.g.dart';

const _defaultMaxDelay = 5;
const _defaultAdvanced = false;
const _defaultHops = 1;
const _defaultSearchTarget = SearchTarget.rootDevice;

@JsonSerializable()
class ProtocolSettings {
  @JsonKey(name: 'maxDelay', defaultValue: _defaultMaxDelay)
  final int maxDelay;

  @JsonKey(name: 'advanced', defaultValue: _defaultAdvanced)
  final bool advanced;

  @JsonKey(name: 'hops', defaultValue: _defaultHops)
  final int hops;

  @JsonKey(name: 'searchTarget', defaultValue: _defaultSearchTarget)
  final String searchTarget;

  const ProtocolSettings({
    this.maxDelay = 5,
    this.advanced = false,
    this.hops = 1,
    this.searchTarget = SearchTarget.rootDevice,
  });

  ProtocolSettings copyWith({
    int? maxDelay,
    bool? advanced,
    int? hops,
    String? searchTarget,
  }) {
    return ProtocolSettings(
        maxDelay: maxDelay ?? this.maxDelay,
        advanced: advanced ?? this.advanced,
        hops: hops ?? this.hops,
        searchTarget: searchTarget ?? this.searchTarget);
  }

  factory ProtocolSettings.fromJson(Map<String, dynamic> json) =>
      _$ProtocolSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ProtocolSettingsToJson(this);
}
