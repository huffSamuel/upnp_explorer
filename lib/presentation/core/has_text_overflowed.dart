import 'package:flutter/material.dart';

bool hasTextOverflowed(
  String text,
  TextStyle style, {
  double minWidth = 0,
  double maxWidth = double.infinity,
  int maxLines = 1,
}) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(
      minWidth: minWidth,
      maxWidth: maxWidth,
    );

  return painter.didExceedMaxLines;
}
