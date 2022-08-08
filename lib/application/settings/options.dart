import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProtocolOptions extends Equatable {
  final int maxDelay;
  final bool advanced;
  final int hops;

  const ProtocolOptions({
    required this.maxDelay,
    required this.advanced,
    required this.hops,
  });

  ProtocolOptions copyWith({
    int? maxDelay,
    bool? advanced,
    int? hops,
  }) {
    return ProtocolOptions(
      maxDelay: maxDelay ?? this.maxDelay,
      advanced: advanced ?? this.advanced,
      hops: hops ?? this.hops,
    );
  }

  @override
  List<Object> get props => [
        maxDelay,
        advanced,
        hops,
      ];
}

class Options extends Equatable {
  final ThemeMode themeMode;
  final VisualDensity visualDensity;
  final ProtocolOptions protocolOptions;

  const Options({
    required this.themeMode,
    required this.visualDensity,
    required this.protocolOptions,
  });

  Options copyWith({
    ThemeMode? themeMode,
    VisualDensity? visualDensity,
    ProtocolOptions? protocolOptions,
  }) {
    return Options(
      themeMode: themeMode ?? this.themeMode,
      visualDensity: visualDensity ?? this.visualDensity,
      protocolOptions: protocolOptions ?? this.protocolOptions,
    );
  }

  static Options base() {
    return Options(
      themeMode: ThemeMode.system,
      visualDensity: VisualDensity.standard,
      protocolOptions: ProtocolOptions(
        advanced: false,
        maxDelay: 3,
        hops: 1,
      ),
    );
  }

  static Options of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    return scope!.modelBindingState.currentModel!;
  }

  static void update(BuildContext context, Options newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    scope!.modelBindingState.updateModel(newModel);
  }

  @override
  List<Object> get props => [
        themeMode ?? 1,
        visualDensity ?? 1,
        protocolOptions ?? 1,
      ];
}

class _ModelBindingScope extends InheritedWidget {
  final _ModelBindingState modelBindingState;

  _ModelBindingScope({
    Key? key,
    required this.modelBindingState,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  ModelBinding({
    Key? key,
    required this.initialModel,
    required this.child,
  }) : super(key: key);

  final Options initialModel;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  Options? currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  void updateModel(Options newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}

String enumToString(Object obj) {
  final str = obj.toString();
  final i = str.indexOf('.') + 1;
  return str.substring(i).toUpperCase();
}
