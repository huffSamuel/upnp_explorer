import 'package:flutter/material.dart';

class SendCommandButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendCommandButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      child: Icon(Icons.arrow_forward),
      style: OutlinedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(24),
      ),
    );
  }
}
