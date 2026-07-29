import 'package:flutter/material.dart';

class _ModelBindingScope<T> extends InheritedWidget {
  const _ModelBindingScope({
    super.key,
    required this.modelBindingState,
    required super.child,
  });

  final ModelBindingState<T> modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding<T> extends StatefulWidget {
  const ModelBinding({
    super.key,
    required this.initialModel,
    required this.child,
    this.onUpdate,
  })  : assert(initialModel != null);

  final T initialModel;
  final Widget child;
  final void Function(T? oldModel, T newModel)? onUpdate;

  @override
  ModelBindingState<T> createState() => ModelBindingState<T>();

  static T of<T>(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope<T>>();

    if (scope == null || scope.modelBindingState.currentModel == null) {
      throw '';
    }

    return scope.modelBindingState.currentModel!;
  }

  static void update<T>(BuildContext context, T newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope<T>>();

    if (scope == null) {
      throw '';
    }

    scope.modelBindingState.updateModel(newModel);
  }
}

class ModelBindingState<T> extends State<ModelBinding<T>> {
  T? currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  void updateModel(T newModel) {
    if (newModel != currentModel) {
      widget.onUpdate?.call(currentModel, newModel);

      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope<T>(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
