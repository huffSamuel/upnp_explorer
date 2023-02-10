import 'package:flutter/material.dart';

dynamic makeRoute(
  BuildContext context,
  Widget child,
) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: transitionBuilder,
  );
}

Widget transitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(position: animation.drive(tween), child: child);
}
