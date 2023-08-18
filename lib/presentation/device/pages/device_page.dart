import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/routing/routes.dart';
import '../../../packages/upnp/upnp.dart';
import '../../core/page/app_page.dart';
import '../../service/pages/service_page.dart';

class DevicePageArguments {
  final DeviceAggregate device;

  DevicePageArguments(this.device);
}

class DevicePage extends StatefulWidget {
  final DeviceAggregate device;
  final Uri deviceLocation;

  const DevicePage({
    Key? key,
    required this.device,
    required this.deviceLocation,
  }) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  int _current = 0;

  _openPresentationUrl() {
    launchUrl(
      widget.device.document.presentationUrl!,
      mode: LaunchMode.externalApplication,
    );
  }

  Iterable<Widget> _info(
    AppLocalizations i18n,
  ) {
    return [
      ListTile(
        title: Text(i18n.manufacturer),
        subtitle: Text(widget.device.document.manufacturer),
        onTap: widget.device.document.manufacturerUrl == null
            ? null
            : () => launchUrl(
                  widget.device.document.manufacturerUrl!,
                  mode: LaunchMode.externalApplication,
                ),
        trailing: widget.device.document.manufacturerUrl == null
            ? null
            : Icon(Icons.chevron_right),
      ),
      ListTile(
        title: Text(i18n.modelName),
        subtitle: Text(widget.device.document.modelName),
        onTap: widget.device.document.modelUrl == null
            ? null
            : () => launchUrl(widget.device.document.modelUrl!,
                mode: LaunchMode.externalApplication),
        trailing: widget.device.document.modelUrl == null
            ? null
            : Icon(Icons.chevron_right),
      ),
      if (widget.device.document.modelNumber != null)
        ListTile(
          title: Text(i18n.modelNumber),
          subtitle: Text(widget.device.document.modelNumber!),
        ),
      if (widget.device.document.modelDescription != null)
        ListTile(
          title: Text(i18n.modelDescription),
          subtitle: Text(widget.device.document.modelDescription!),
        ),
      if (widget.device.document.serialNumber != null)
        ListTile(
          title: Text(i18n.serialNumber),
          subtitle: Text(widget.device.document.serialNumber!),
        )
    ];
  }

  VoidCallback? _navigateToService(
      BuildContext context, ServiceAggregate service) {
    return () {
      Navigator.of(context).push(
        makeRoute(
          context,
          ServicePage(service: service),
        ),
      );
    };
  }

  Iterable<Widget> _services(AppLocalizations i18n) {
    if (widget.device.services.length == 0) {
      return [
        Center(child: Text(i18n.nothingHere)),
      ];
    }

    return widget.device.services.map(
      (service) {
        final onTap = service.service == null
            ? null
            : _navigateToService(context, service);

        return ListTile(
          title: Text(service.document.serviceId.serviceId),
          trailing: onTap == null ? null : Icon(Icons.chevron_right),
          subtitle: onTap == null ? Text(i18n.unableToObtainInformation) : null,
          onTap: onTap,
        );
      },
    );
  }

  void _onDeviceTapped(BuildContext context, DeviceAggregate device) {
    Navigator.of(context).push(
      makeRoute(
        context,
        DevicePage(
          device: device,
          deviceLocation: widget.deviceLocation,
        ),
      ),
    );
  }

  Iterable<Widget> _devices(AppLocalizations i18n) {
    if (widget.device.devices.length == 0) {
      return [
        Center(child: Text(i18n.nothingHere)),
      ];
    }

    return widget.device.devices.map(
      (device) {
        return ListTile(
          title: Text(device.document.deviceType.deviceType),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _onDeviceTapped(context, device),
        );
      },
    );
  }

  void _navigate(int index) {
    if (index < 0 || index > 2) {
      throw '';
    }

    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return AppPage(
      title: Text(widget.device.document.friendlyName),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current,
        onTap: _navigate,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.device_hub_rounded),
            label: 'Devices',
          ),
        ],
      ),
      actions: [
        if (widget.device.document.presentationUrl != null)
          IconButton(
            tooltip: i18n.openPresentationInBrowser,
            icon: Icon(Icons.open_in_browser),
            onPressed: _openPresentationUrl,
          ),
        PopupMenuButton(
          icon: Icon(
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
                widget.deviceLocation,
                mode: LaunchMode.externalApplication,
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
              if (_current == 0) ..._info(i18n),
              if (_current == 1) ..._services(i18n),
              if (_current == 2) ..._devices(i18n),
            ],
          ),
        ),
      ],
    );
  }
}
