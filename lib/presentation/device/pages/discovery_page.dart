import 'dart:async';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:upnped/upnped.dart';

import '../../../application/application.dart';
import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/app_localizations.dart';
import '../../../application/routing/routes.dart';
import '../../changelog/page/changelog_page.dart';
import '../../network_logs/pages/logs_page.dart';
import '../widgets/device_expansion_tile.dart';
import '../widgets/refresh_button.dart';
import '../widgets/scanning_indicator.dart';
import '../widgets/settings_icon_button.dart';
import 'service.dart';

class _NoNetwork extends StatelessWidget {
  const _NoNetwork();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(i18n.discoveryRequiresNetwork),
          const SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () => switch (OpenSettingsPlus.shared) {
              OpenSettingsPlusAndroid settings => settings.wifi(),
              OpenSettingsPlusIOS settings => settings.wifi(),
              _ => throw Exception('Platform not supported'),
            },
            child: Text(i18n.turnOnWifi),
          ),
        ],
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Device> devices;
  final bool scanning;

  const _Loaded({
    Key? key,
    required this.onRefresh,
    required this.scanning,
    required this.devices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty && !scanning) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context)!.noDevicesFound,
          ),
        ),
      );
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: ImplicitlyAnimatedList<Device>(
            items: devices,
            insertDuration: Duration(milliseconds: 150),
            removeDuration: Duration.zero,
            itemBuilder: (context, animation, item, index) => FadeTransition(
              opacity: animation,
              child: DeviceExpansionTile(
                device: item,
              ),
            ),
            areItemsTheSame: (a, b) => a.description.udn == b.description.udn,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ScanningIndicator(
            height: scanning ? 8 : 0,
          ),
        ),
      ],
    );
  }
}

class DiscoveryPage extends StatefulWidget {
  final DiscoveryStateService _service;
  final ChangelogService _changelog;

  DiscoveryPage({
    DiscoveryStateService? service,
    ChangelogService? changelog,
  })  : _service = service ?? sl<DiscoveryStateService>(),
        _changelog = changelog ?? sl<ChangelogService>();

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  void initState() {
    widget._changelog.shouldDisplayChangelog().then((display) {
      if (display) {
        Navigator.of(context).push(
          makeRoute(
            context,
            ChangelogPage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    final actions = [
      IconButton(
        tooltip: i18n.viewNetworkTraffic,
        icon: const Icon(Icons.description_outlined),
        onPressed: () => Navigator.of(context).push(
          makeRoute(
            context,
            LogsPage(),
          ),
        ),
      ),
      RefreshIconButton(
        service: widget._service,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const SettingsIconButton(),
        title: Text(Application.name),
        actions: actions,
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget._service.state,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.hasError ||
                snapshot.data!.loading) {
              return const SizedBox();
            }

            if (!snapshot.data!.viableNetwork) {
              return const _NoNetwork();
            }

            return _Loaded(
              onRefresh: widget._service.search,
              scanning: snapshot.data!.scanning,
              devices: snapshot.data!.devices,
            );
          },
        ),
      ),
    );
  }
}
