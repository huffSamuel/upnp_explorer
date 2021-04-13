import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import '../../core/widgets/raw-toggle-widget.dart';
import '../../core/widgets/xml-node-view.dart';

class DeviceDescriptionWidget extends StatelessWidget {
  final XmlDocument description;

  const DeviceDescriptionWidget({Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawToggleWidget(
      raw: Text(description.toXmlString(pretty: true)),
      formatted: XmlNodeView(
        element: description.rootElement,
        displaySelf: false,
      ),
    );
  }
}
