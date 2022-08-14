import 'package:flutter/material.dart';

class RefreshIconButton extends StatelessWidget {
  final Function()? onPressed;

  const RefreshIconButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Refresh',
      icon: Icon(Icons.refresh),
      onPressed: onPressed,
    );
  }
}
