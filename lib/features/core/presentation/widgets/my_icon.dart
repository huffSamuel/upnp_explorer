import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? color;
  final double? size;

  const MyIcon(
      {super.key,
      required this.icon,
      this.backgroundColor,
      this.color,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
