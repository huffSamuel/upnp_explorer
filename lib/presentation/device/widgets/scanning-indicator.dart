import 'package:flutter/material.dart';

class ScanningIndicator extends StatelessWidget {
  final double height;

  const ScanningIndicator({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 150),
      child: LinearProgressIndicator(
        backgroundColor: Theme.of(context).canvasColor,
        valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
      ),
    );
  }
}
