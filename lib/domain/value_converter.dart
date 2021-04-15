import 'package:flutter/material.dart';

abstract class ValueConverter<A, B> {
  const ValueConverter();

  B to(A value);
  A from(B value);
}

const kVisualDensityConverter = const VisualDensityConverter();

const _kVisualDensityMap = {
  Density.comfortable: VisualDensity.comfortable,
  Density.compact: VisualDensity.compact,
  Density.standard: VisualDensity.standard
};

class VisualDensityConverter extends ValueConverter<Density, VisualDensity> {
  const VisualDensityConverter() : super();

  @override
  Density from(VisualDensity value) {
    return _kVisualDensityMap.keys.firstWhere(
      (k) => _kVisualDensityMap[k] == value,
      orElse: () => null,
    );
  }

  @override
  VisualDensity to(Density value) {
    return _kVisualDensityMap[value];
  }
}

enum Density {
  standard,
  comfortable,
  compact,
}
