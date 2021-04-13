import 'package:flutter/material.dart';

class FadeInContainer extends StatefulWidget {
  final Duration duration;
  final Widget child;

  const FadeInContainer({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 250),
  })  : assert(duration != null),
        assert(child != null),
        super(key: key);

  @override
  _FadeInContainerState createState() => _FadeInContainerState();
}

class _FadeInContainerState extends State<FadeInContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
