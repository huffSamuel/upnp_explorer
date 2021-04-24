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
    return keyFromValue(_kVisualDensityMap, value);
  }

  @override
  VisualDensity to(Density value) {
    return _kVisualDensityMap[value];
  }
}

A keyFromValue<A, B>(
  Map<A, B> map,
  B value,
) {
  return map.keys.firstWhere(
    (k) => map[k] == value,
    orElse: () => null,
  );
}

enum Density {
  standard,
  comfortable,
  compact,
}
