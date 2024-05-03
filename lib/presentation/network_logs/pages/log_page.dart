import 'package:fl_upnp/fl_upnp.dart';
import 'package:flutter/material.dart';
import '../widgets/timestamp.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/log_content.dart';
import '../widgets/log_direction.dart';

class LogPage extends StatelessWidget {
  final NetworkEvent event;

  const LogPage({super.key, required this.event});

  Widget _url(BuildContext context) {
    if (event.messageType == 'HTTP GET') {
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            event.to!,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () => launchUrlString(event.to!),
      );
    }

    return Text(event.from!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, bottom: 4.0, right: 4.0),
        child: Scrollbar(
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    event.messageType,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 6),
                  LogDirection(direction: event.direction),
                ],
              ),
              Row(
                children: [
                  Text('at'),
                  const SizedBox(width: 6.0),
                  Timestamp(time: event.time),
                ],
              ),
              if (event.from != null && event.from != '127.0.0.1')
                _url(context),
              SizedBox(height: 8),
              LogContent(event: event),
            ],
          ),
        ),
      ),
    );
  }
}
