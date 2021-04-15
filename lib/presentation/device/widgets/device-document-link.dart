import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceDocumentLink extends StatelessWidget {
  final String location;
  final TextStyle style;

  const DeviceDocumentLink({
    Key key,
    @required this.location,
    this.style,
  })  : assert(location != null && location.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ??
        Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(decoration: TextDecoration.underline, color: Colors.blue);

    return GestureDetector(
      onTap: () => _launch(),
      child: Text(location, style: effectiveStyle, overflow: TextOverflow.fade),
    );
  }

  void _launch() async {
    if (await canLaunch(location)) {
      launch(location);
    }
  }
}
