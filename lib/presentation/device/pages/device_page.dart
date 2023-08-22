import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/routing/routes.dart';
import '../../../packages/upnp/upnp.dart';
import '../../core/page/app_page.dart';
import '../../service/pages/service_page.dart';

class DevicePage extends StatelessWidget {
  final DeviceAggregate device;
  final Uri deviceLocation;
  const DevicePage({
    Key? key,
    required this.device,
    required this.deviceLocation,
  }) : super(key: key);

  _openPresentationUrl() {
    launchUrl(
      device.document.presentationUrl!,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: AppPage(
        title: Text(device.document.friendlyName),
        actions: [
          if (device.document.presentationUrl != null)
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
              _DeviceInfoTabView(device: device),
              _ServicesTabView(device: device),
              _SubdevicesTabView(
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

class DevicePageNavigationBar extends StatefulWidget {
  final TabController? controller;

  const DevicePageNavigationBar({
    super.key,
    this.controller,
  });

  @override
  State<DevicePageNavigationBar> createState() =>
      _DevicePageNavigationBarState();
}

class _DevicePageNavigationBarState extends State<DevicePageNavigationBar> {
  TabController? _controller;

  @override
  void dispose() {
    _controller?.removeListener(_handleControllerTick);

    super.dispose();
  }

  bool get _isControllerValid => _controller?.animation != null;

  didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
  }

  @override
  didUpdateWidget(DevicePageNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
    }
  }

  _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.maybeOf(context);

    assert(() {
      if (newController == null) {
        throw Error();
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }

    if (_isControllerValid) {
      _controller!.removeListener(_handleControllerTick);
    }

    _controller = newController;

    if (_controller != null) {
      _controller!.addListener(_handleControllerTick);
    }
  }

  _handleControllerTick() {
    setState(() {
      // Trigger the rebuild with the controller's index
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _controller!.index,
      onTap: _controller!.animateTo,
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
    );
  }
}

class _SubdevicesTabView extends StatelessWidget {
  final DeviceAggregate device;
  final Uri deviceLocation;

  const _SubdevicesTabView({
    super.key,
    required this.device,
    required this.deviceLocation,
  });

  void _onDeviceTapped(BuildContext context, DeviceAggregate device) {
    Navigator.of(context).push(
      makeRoute(
        context,
        DevicePage(
          device: device,
          deviceLocation: deviceLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    List<Widget> body;

    if (device.devices.length == 0) {
      body = [
        Center(child: Text(i18n.nothingHere)),
      ];
    } else {
      body = List.from(device.devices.map(
        (device) {
          return ListTile(
            title: Text(device.document.deviceType.deviceType),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _onDeviceTapped(context, device),
          );
        },
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ),
    );
  }
}

class _ServicesTabView extends StatelessWidget {
  final DeviceAggregate device;

  const _ServicesTabView({
    super.key,
    required this.device,
  });

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

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    List<Widget> body;

    if (device.services.isEmpty) {
      body = [
        Center(child: Text(i18n.nothingHere)),
      ];
    } else {
      body = List.from(
        device.services.map(
          (service) {
            final onTap = service.service == null
                ? null
                : _navigateToService(context, service);

            return ListTile(
              title: Text(service.document.serviceId.serviceId),
              trailing: onTap == null ? null : Icon(Icons.chevron_right),
              subtitle:
                  onTap == null ? Text(i18n.unableToObtainInformation) : null,
              onTap: onTap,
            );
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ),
    );
  }
}

class _DeviceInfoTabView extends StatelessWidget {
  final DeviceAggregate device;

  const _DeviceInfoTabView({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(i18n.manufacturer),
            subtitle: Text(device.document.manufacturer),
            onTap: device.document.manufacturerUrl == null
                ? null
                : () => launchUrl(
                      device.document.manufacturerUrl!,
                      mode: LaunchMode.externalApplication,
                    ),
            trailing: device.document.manufacturerUrl == null
                ? null
                : Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(i18n.modelName),
            subtitle: Text(device.document.modelName),
            onTap: device.document.modelUrl == null
                ? null
                : () => launchUrl(device.document.modelUrl!,
                    mode: LaunchMode.externalApplication),
            trailing: device.document.modelUrl == null
                ? null
                : Icon(Icons.chevron_right),
          ),
          if (device.document.modelNumber != null)
            ListTile(
              title: Text(i18n.modelNumber),
              subtitle: Text(device.document.modelNumber!),
            ),
          if (device.document.modelDescription != null)
            ListTile(
              title: Text(i18n.modelDescription),
              subtitle: Text(device.document.modelDescription!),
            ),
          if (device.document.serialNumber != null)
            ListTile(
              title: Text(i18n.serialNumber),
              subtitle: Text(device.document.serialNumber!),
            )
        ],
      ),
    );
  }
}
