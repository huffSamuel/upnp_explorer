import 'package:flutter/material.dart';
import 'package:upnp_explorer/presentation/network_logs/widgets/timestamp.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/log_content.dart';
import '../widgets/log_direction.dart';
import '../../../libraries/simple_upnp/src/upnp.dart';

class LogPage extends StatelessWidget {
  final UPnPEvent event;

  const LogPage({super.key, required this.event});

  Widget _url(BuildContext context) {
    if (event.discriminator == 'HTTP GET') {
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            event.address!,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () => launchUrlString(event.address!),
      );
    }

    return Text(event.address!);
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
        padding: const EdgeInsets.all(4.0),
        child: Scrollbar(
          child: ListView(
            children: [
              Timestamp(time: event.time),
              Row(
                children: [
                  Text(
                    event.discriminator,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 6),
                  LogDirection(direction: event.direction),
                ],
              ),
              if (event.address != null && event.address != '127.0.0.1')
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
