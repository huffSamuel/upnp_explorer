import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../presentation/core/widgets/model_binding.dart';

class ProtocolSettings {
  final int maxDelay;
  final bool advanced;
  final int hops;
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
}

class Settings {
  final ThemeMode themeMode;
  final VisualDensity visualDensity;
  final ProtocolSettings protocolOptions;

  const Settings({
    required this.themeMode,
    required this.visualDensity,
    required this.protocolOptions,
  });

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

  static Settings base() {
    return Settings(
      themeMode: ThemeMode.system,
      visualDensity: VisualDensity.standard,
      protocolOptions: ProtocolSettings(
          advanced: false,
          maxDelay: 3,
          hops: 1,
          searchTarget: 'upnp:rootdevice'),
    );
  }

  static Settings of(BuildContext context) =>
      ModelBinding.of<Settings>(context);

  static void update(BuildContext context, Settings newModel) =>
      ModelBinding.update(context, newModel);
}
