import 'package:flutter/material.dart';

class StatusDot extends StatelessWidget {
  final Stream<bool> stream;

  const StatusDot({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: snapshot.data == true ? Colors.green : Colors.red,
              ),
              height: 10,
              width: 10,
            ),
          ),
        );
      },
    );
  }
}
