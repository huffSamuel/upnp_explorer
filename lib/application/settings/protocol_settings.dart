import '../../libraries/simple_upnp/simple_upnp.dart';

const _MAX_DELAY = 'max_delay';
const _ADVANCED = 'advanced';
const _HOPS = 'hops';
const _SEARCH_TARGET = 'search_target';

const _DEFAULT_MAX_DELAY = 3;
const _DEFAULT_ADVANCED = false;
const _DEFAULT_HOPS = 1;
const _DEFAULT_SEARCH_TARGET = SearchTarget.rootDevice;

class ProtocolSettings {
  final int maxDelay;
  final bool advanced;
  final int hops;
  final String searchTarget;

  const ProtocolSettings({
    this.maxDelay = _DEFAULT_MAX_DELAY,
    this.advanced = _DEFAULT_ADVANCED,
    this.hops = _DEFAULT_HOPS,
    this.searchTarget = _DEFAULT_SEARCH_TARGET,
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
      searchTarget: searchTarget ?? this.searchTarget,
    );
  }

  factory ProtocolSettings.fromJson(Map<String, dynamic> json) {
    return ProtocolSettings(
      maxDelay: json[_MAX_DELAY],
      advanced: json[_ADVANCED],
      hops: json[_HOPS],
      searchTarget: json[_SEARCH_TARGET],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _ADVANCED: advanced,
      _MAX_DELAY: maxDelay,
      _HOPS: hops,
      _SEARCH_TARGET: searchTarget,
    };
  }
}
