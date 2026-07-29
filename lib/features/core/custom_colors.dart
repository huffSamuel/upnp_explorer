import 'package:flutter/material.dart';

class MyCustomColors extends ThemeExtension<MyCustomColors> {
  final Color? brandSuccess;
  final Color? onSuccess;

  MyCustomColors({this.brandSuccess, this.onSuccess});
  
  @override
  ThemeExtension<MyCustomColors> copyWith({
    Color? brandSuccess,
    Color? onSuccess,
  }) {
    return MyCustomColors(brandSuccess: brandSuccess ?? brandSuccess, onSuccess: onSuccess ?? onSuccess);
  }

  @override
  ThemeExtension<MyCustomColors> lerp(covariant ThemeExtension<MyCustomColors>? other, double t) {
    if (other is! MyCustomColors) {
      return this;
    }

    return MyCustomColors(
      brandSuccess: Color.lerp(brandSuccess, other.brandSuccess, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
    );
  }
}