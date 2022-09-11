import 'package:flutter/material.dart';

class ReviewPromptDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate UPnP Explorer'),
      content: Text(
          'If you like UPnP Explorer or you\'ve found something we need to work on, we\'d love to hear about it. We would greatly appreciate it if you could rate the app on the Play Store. Thanks!'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(onPressed: () {}, child: Text('Not now')),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Rate UPnP Explorer'),
                ),
                TextButton(
                  onPressed: () {},
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: Colors.red),
                    child: Text('Never ask again'),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
