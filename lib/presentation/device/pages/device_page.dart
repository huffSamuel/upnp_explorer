import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

import '../../../application/routing/routes.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/ssdp_response_message.dart';
import '../../core/page/app_page.dart';
import '../../core/page/view_document_page.dart';
import '../../core/widgets/row_count.dart';
import 'device_list_page.dart';
import 'service_list_page.dart';

class DevicePageArguments {
  final Device device;
  final XmlDocument? xml;
  final DiscoveryResponse message;

  DevicePageArguments(
    this.device,
    this.message, {
    this.xml,
  });
}

class DevicePage extends StatelessWidget {
  final Device device;
  final Uri deviceLocation;
  final XmlDocument? xml;

  const DevicePage({
    Key? key,
    required this.device,
    required this.deviceLocation,
    this.xml,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    Widget? fab;

    if (device.presentationUrl != null) {
      fab = FloatingActionButton(
        tooltip: i18n.openPresentationInBrowser,
        onPressed: () {
          launchUrl(
            device.presentationUrl!,
            mode: LaunchMode.externalApplication,
          );
        },
        child: Icon(
          Icons.open_in_browser_rounded,
        ),
      );
    }

    return AppPage(
      floatingActionButton: fab,
      title: Text(device.friendlyName),
      actions: [
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Text(i18n.openInBrowser),
            ),
            if (xml != null)
              PopupMenuItem(
                value: 1,
                child: Text(i18n.viewXml),
              )
          ],
          onSelected: (value) {
            if (value == 0) {
              launchUrl(
                deviceLocation,
                mode: LaunchMode.externalApplication,
              );
            } else if (value == 1) {
              Navigator.of(context).push(
                makeRoute(
                  context,
                  XmlDocumentPage(
                    xml: xml!,
                  ),
                ),
              );
            }
          },
        ),
      ],
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(i18n.manufacturer),
                subtitle: Text(device.manufacturer),
                onTap: device.manufacturerUrl == null
                    ? null
                    : () => launchUrl(
                          device.manufacturerUrl!,
                          mode: LaunchMode.externalApplication,
                        ),
                trailing: device.manufacturerUrl == null
                    ? null
                    : Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text(i18n.modelName),
                subtitle: Text(device.modelName),
                onTap: device.modelUrl == null
                    ? null
                    : () => launchUrl(device.modelUrl!,
                        mode: LaunchMode.externalApplication),
                trailing:
                    device.modelUrl == null ? null : Icon(Icons.chevron_right),
              ),
              if (device.modelNumber != null)
                ListTile(
                  title: Text(i18n.modelNumber),
                  subtitle: Text(device.modelNumber!),
                ),
              if (device.modelDescription != null)
                ListTile(
                  title: Text(i18n.modelDescription),
                  subtitle: Text(device.modelDescription!),
                ),
              if (device.serialNumber != null)
                ListTile(
                  title: Text(i18n.serialNumber),
                  subtitle: Text(device.serialNumber!),
                ),
              if (device.services.isNotEmpty)
                ListTile(
                  title: Text(i18n.services),
                  subtitle: RowCountOverflowed(
                    labels: List.from(
                      device.services.map((x) => x.serviceId.serviceId),
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    makeRoute(
                      context,
                      ServiceListPage(
                        services: device.services,
                        deviceId: device.udn,
                      ),
                    ),
                  ),
                ),
              if (device.devices.isNotEmpty)
                ListTile(
                  title: Text(i18n.devicesN(device.devices.length)),
                  subtitle: Text(
                    device.devices
                        .take(3)
                        .map(
                          (x) => x.deviceType.type,
                        )
                        .join(i18n.listSeparator),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    makeRoute(
                      context,
                      DeviceListPage(
                        devices: device.devices,
                        deviceLocation: deviceLocation,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
