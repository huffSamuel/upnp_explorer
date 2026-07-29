import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart' show Service;

import '../../../../extension/build_context.dart';
import '../../../core/presentation/widgets/list_tile_splash_host.dart';
import '../../../core/presentation/widgets/my_icon.dart';
import '../../../core/presentation/widgets/section_header.dart';
import '../../../core/util/upnp.dart';
import '../pages/service_information_page.dart';
import 'item_list_card.dart';

class ServicesCard extends StatelessWidget {
  final List<Service> services;

  const ServicesCard({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return ItemListCard(
      items: services,
      title: SectionHeader(
        icon: Icon(Icons.hub_outlined),
        title: Text(i18n.upnpServices),
      ),
      itemBuilder: (c, i) => ListTileSplashHost(
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: MyIcon(
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            color: theme.colorScheme.primary,
            icon: mapServiceIcon(i.document.serviceId.toString()),
          ),
          title: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(i.document.serviceType),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ServiceInformationPage(
                  service: i,
                ),
              ),
            );
          },
          visualDensity: VisualDensity.compact,
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

IconData mapServiceIcon(String schema) {
  final icon = getServiceIcon(schema);

  if (icon != null) {
    return icon;
  }

  if (!isWellKnown(schema)) {
    return Icons.extension_outlined;
  }

  return Icons.miscellaneous_services_outlined;
}

class WellKnownServices {
  static const String layer3Forwarding = 'Layer3Forwarding1';
  static const String wanIPConnection = 'WANIPConnection';
  static const String wanPPPConnection = 'WANPPPConnection';
  static const String wanCommonInterfaceConfig = 'WANCommonInterfaceConfig';
  static const String lanHostConfigManagement = 'LANHostConfigManagement';
  static const String contentDirectory = 'ContentDirectory';
  static const String connectionManager = 'ConnectionManager';
  static const String renderingControl = 'RenderingControl';
  static const String avTransport = 'AVTransport';
  static const String switchPower = 'SwitchPower';
  static const String dimming = 'Dimming';
  static const String wanCommonIfc = 'WANCommonIFC1';
  static const String wanIpConn = 'WANIPConn1';
}

final wellKnownServiceIconMap = {
  WellKnownServices.layer3Forwarding: Icons.swap_horiz_outlined,
  WellKnownServices.wanIPConnection: Icons.settings_ethernet_outlined,
  WellKnownServices.wanPPPConnection: Icons.vpn_key_outlined,
  WellKnownServices.wanCommonInterfaceConfig: Icons.speed_outlined,
  WellKnownServices.lanHostConfigManagement: Icons.lan_outlined,
  WellKnownServices.contentDirectory: Icons.folder_copy_outlined,
  WellKnownServices.connectionManager: Icons.connect_without_contact_outlined,
  WellKnownServices.renderingControl: Icons.display_settings_outlined,
  WellKnownServices.avTransport: Icons.video_settings_outlined,
  WellKnownServices.switchPower: Icons.power_settings_new_outlined,
  WellKnownServices.dimming: Icons.light_mode_outlined,
  WellKnownServices.wanCommonIfc: Icons.speed_outlined,
  WellKnownServices.wanIpConn: Icons.settings_ethernet_outlined,
};

IconData? getServiceIcon(String serviceType) {
  for (var entry in wellKnownServiceIconMap.entries) {
    if (serviceType.endsWith(entry.key)) {
      return entry.value;
    }
  }

  return null;
}
