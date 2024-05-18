import 'package:flutter/material.dart';

enum TransitionDirection { fromLeft, fromRight }

dynamic makeRoute(
  BuildContext context,
  Widget child, {
  TransitionDirection direction = TransitionDirection.fromRight,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (c, a, sa, ch) => transitionBuilder(
      c,
      a,
      sa,
      ch,
      direction,
    ),
  );
}

Widget transitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
  TransitionDirection direction,
) {
  var begin = direction == TransitionDirection.fromRight
      ? Offset(1.0, 0.0)
      : Offset(-1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(position: animation.drive(tween), child: child);
}
