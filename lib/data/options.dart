import 'package:flutter/material.dart';

class Options {
  final ThemeMode themeMode;
  final VisualDensity visualDensity;

  const Options({
    this.themeMode,
    this.visualDensity,
  });

  Options copyWith({ThemeMode themeMode, VisualDensity visualDensity}) {
    return Options(
      themeMode: themeMode ?? this.themeMode,
      visualDensity: visualDensity ?? this.visualDensity,
    );
  }

  static Options of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, Options newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    scope.modelBindingState.updateModel(newModel);
  }
}

class _ModelBindingScope extends InheritedWidget {
  final _ModelBindingState modelBindingState;

  _ModelBindingScope({
    Key key,
    @required this.modelBindingState,
    Widget child,
  })  : assert(modelBindingState != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  ModelBinding({
    Key key,
    this.initialModel = const Options(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);

  final Options initialModel;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  Options currentModel;

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
