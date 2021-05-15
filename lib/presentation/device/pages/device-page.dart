import 'package:flutter/material.dart';

import '../../../domain/device.dart';
import '../../../generated/l10n.dart';
import '../widgets/device-description-widget.dart';
import '../widgets/device-expansion-tile.dart';
import '../widgets/response-widget.dart';

class DevicePage extends StatelessWidget {
  final Device device;

  const DevicePage({Key key, this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    final documents = device.documents
        .map(
          (doc) => DeviceExpansionTile(
            title: Text(i18n.deviceDocument),
            subtitle: Text(doc.name),
            child: DeviceDescriptionWidget(
              description: doc.xmlDocument,
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybeOf(context).pop(),
        ),
        title: Text(
            device.properties.friendlyName ?? device.response.parsed['usn']),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DeviceExpansionTile(
                title: Text(i18n.response),
                initiallyExpanded: true,
                child: ResponseWidget(response: device.response),
              ),
              ...documents
            ],
          ),
        ),
      ),
    );
  }
}
