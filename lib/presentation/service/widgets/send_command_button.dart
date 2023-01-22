import 'package:flutter/material.dart';

class SendCommandButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;

  const SendCommandButton({
    Key? key,
    required this.onPressed,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed?.call();
      },
      child: Semantics(
        label: 'Send $name command',
        child: Icon(Icons.arrow_forward)),
      style: OutlinedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(24),
      ),
    );
  }
}
