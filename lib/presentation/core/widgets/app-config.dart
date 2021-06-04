import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final AppConfigData data;

  AppConfig(
    this.data,
    Widget child,
  ) : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class AppConfigData {
  final String displayName;
  final int internalId;

  AppConfigData(
    this.displayName,
    this.internalId,
  );
}
