import 'dart:async';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_settings/open_settings.dart';
import '../widgets/device_expansion_tile.dart';
import 'package:upnped/upnped.dart';

import '../../../application/application.dart';
import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../application/routing/routes.dart';
import '../../changelog/page/changelog_page.dart';
import '../../network_logs/pages/logs_page.dart';
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
            onPressed: OpenSettings.openWIFISetting,
            child: Text(i18n.turnOnWifi),
          ),
        ],
      ),
    );
  }
}

const useNew = true;

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

class DiscoveryPage extends StatelessWidget {
  final DiscoveryStateService _service;
  final ChangelogService _changelog;

  DiscoveryPage({
    DiscoveryStateService? service,
    ChangelogService? changelog,
  })  : _service = service ?? sl<DiscoveryStateService>(),
        _changelog = changelog ?? sl<ChangelogService>();

  void _checkChangelog(BuildContext context) {
    _changelog.shouldDisplayChangelog().then((display) {
      if (display) {
        Navigator.of(context).push(
          makeRoute(
            context,
            ChangelogPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkChangelog(context);
    });

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
        service: _service,
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
          stream: _service.state,
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
              onRefresh: _service.search,
              scanning: snapshot.data!.scanning,
              devices: snapshot.data!.devices,
            );
          },
        ),
      ),
    );
  }
}
