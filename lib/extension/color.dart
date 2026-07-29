import 'package:flutter/material.dart';

extension ColorX on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    if (amount == 0) {
      return this;
    }

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
