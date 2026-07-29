import 'package:flutter/material.dart';

class ListTileSplashHost extends StatelessWidget {
  final Widget child;

  const ListTileSplashHost({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: Material(color: Colors.transparent, child: child));
  }
}