import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../extension/build_context.dart';
import '../../../../util/string.dart';
import '../../../core/presentation/widgets/external_link.dart';
import '../../../core/presentation/widgets/labeled_field.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/section_header.dart';

class DeviceInformationCard extends StatelessWidget {
  final DeviceDescription device;

  const DeviceInformationCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    return MyCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            icon: Icon(Icons.info),
            title: Text(i18n.deviceInformation),
          ),
          const SizedBox(height: 4),
          if (device.manufacturer.isNotEmpty)
            LabeledField(
                label: Text(i18n.manufacturer.toUpperCase()),
                child: ExternalLink(
                  url: device.manufacturerUrl,
                  child: Text(device.manufacturer),
                )),
          if (device.modelName.isNotEmpty)
            LabeledField(
              label: Text(i18n.modelName.toUpperCase()),
              child: ExternalLink(
                url: device.modelUrl,
                child: Text(device.modelName),
              ),
            ),
          if (isNotNullOrEmpty(device.modelNumber))
            LabeledField(
              label: Text(i18n.modelNumber.toUpperCase()),
              child: Text(device.modelNumber!),
            ),
          if (isNotNullOrEmpty(device.modelDescription))
            LabeledField(
              label: Text(i18n.modelDescription.toUpperCase()),
              child: Text(device.modelDescription!),
            ),
          if (isNotNullOrEmpty(device.serialNumber))
            LabeledField(
              label: Text(i18n.serialNumber.toUpperCase()),
              child: Text(device.serialNumber!),
            ),
        ],
      ),
    );
  }
}
