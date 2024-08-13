import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

String tag(String name, bool isFinal) =>
    isFinal ? name + '.final' : name + '.screen';

List<Device> viewports(bool isFinal) => [
      Device(
          name: tag('android.phone', isFinal),
          size: Size(1107 / 3, 1968 / 3),
          textScale: 1,
          devicePixelRatio: 3),
      Device(
        name: tag('android.tablet.7', isFinal),
        size: Size(1206 / 2, 2144 / 2),
        textScale: 1,
        devicePixelRatio: 2,
      ),
      Device(
        name: tag('android.tablet.10', isFinal),
        size: Size(1449 / 2, 2576 / 2),
        textScale: 1,
        devicePixelRatio: 2,
      )
    ];

Future<void> takeScreenshot({
  required WidgetTester tester,
  required Widget widget,
  required String pageName,
  required bool isFinal,
  required Size sizeDp,
  required double density,
  CustomPump? customPump,
}) async {
  await tester.pumpWidgetBuilder(widget);
  await multiScreenGolden(
    tester,
    pageName,
    customPump: customPump,
    devices: [
      Device(
        name: isFinal ? "final" : "screen",
        size: sizeDp,
        textScale: 1,
        devicePixelRatio: density,
      ),
    ],
  );
}

Image loadGoldenImage(String name) {
  final screenFile = File("test/goldens/$name.screen.png");
  final memoryImage = MemoryImage(screenFile.readAsBytesSync());
  return Image(image: memoryImage);
}
