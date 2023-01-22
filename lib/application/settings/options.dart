import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../presentation/core/widgets/model_binding.dart';

class ProtocolOptions extends Equatable {
  final int maxDelay;
  final bool advanced;
  final int hops;
  final String searchTarget;

  const ProtocolOptions({
    required this.maxDelay,
    required this.advanced,
    required this.hops,
    required this.searchTarget
  });

  ProtocolOptions copyWith({
    int? maxDelay,
    bool? advanced,
    int? hops,
    String? searchTarget
  }) {
    return ProtocolOptions(
      maxDelay: maxDelay ?? this.maxDelay,
      advanced: advanced ?? this.advanced,
      hops: hops ?? this.hops,
      searchTarget: searchTarget ?? this.searchTarget
    );
  }

  @override
  List<Object> get props => [
        maxDelay,
        advanced,
        hops,
        searchTarget
      ];
}

class Options extends Equatable {
  final ThemeMode themeMode;
  final VisualDensity visualDensity;
  final ProtocolOptions protocolOptions;
  final bool material3;

  const Options({
    required this.themeMode,
    required this.visualDensity,
    required this.protocolOptions,
    required this.material3,
  });

  Options copyWith({
    ThemeMode? themeMode,
    VisualDensity? visualDensity,
    ProtocolOptions? protocolOptions,
    bool? material3,
  }) {
    return Options(
      themeMode: themeMode ?? this.themeMode,
      visualDensity: visualDensity ?? this.visualDensity,
      protocolOptions: protocolOptions ?? this.protocolOptions,
      material3: material3 ?? this.material3
    );
  }

  static Options base() {
    return Options(
      material3: false,
      themeMode: ThemeMode.system,
      visualDensity: VisualDensity.standard,
      protocolOptions: ProtocolOptions(
        advanced: false,
        maxDelay: 3,
        hops: 1,
        searchTarget: 'upnp:rootdevice'
      ),
    );
  }

  static Options of(BuildContext context) => ModelBinding.of<Options>(context);

  static void update(BuildContext context, Options newModel) => ModelBinding.update(context, newModel);

  @override
  List<Object> get props => [
        themeMode,
        visualDensity,
        protocolOptions,
        material3,
      ];
}

String enumToString(Object obj) {
  final str = obj.toString();
  final i = str.indexOf('.') + 1;
  return str.substring(i).toUpperCase();
}
