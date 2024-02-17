import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Timestamp extends StatelessWidget {
  final DateTime time;

  const Timestamp({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('HH:mm:ss.SSS').format(time),
      style: TextStyle(
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
