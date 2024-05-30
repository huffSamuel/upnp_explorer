import 'package:upnped/upnped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/page/app_page.dart';
import '../widgets/device_page_navigation_bar.dart';
import 'device_info_page.dart';
import 'services_page.dart';
import 'subdevices_page.dart';

class DevicePage extends StatelessWidget {
  final Device device;
  final Uri deviceLocation;
  const DevicePage({
    Key? key,
    required this.device,
    required this.deviceLocation,
  }) : super(key: key);

  _openPresentationUrl() {
    launchUrl(
      device.description.presentationUrl!,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: AppPage(
        title: Text(device.description.friendlyName),
        actions: [
          if (device.description.presentationUrl != null)
            IconButton(
              tooltip: i18n.openPresentationInBrowser,
              icon: Icon(Icons.open_in_browser),
              onPressed: _openPresentationUrl,
            ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(i18n.openInBrowser),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                launchUrl(
                  deviceLocation,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
        ],
        bottomNavigationBar: DevicePageNavigationBar(),
        children: [
          TabBarView(
            children: [
              DeviceInfoPage(device: device.description),
              ServicesPage(device: device),
              SubDevicesPage(
                device: device,
                deviceLocation: deviceLocation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
