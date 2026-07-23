import 'dart:async';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/changelog/changelog_service.dart';
import '../../../../application/ioc.dart';
import '../../../../application/routing/routes.dart';
import '../../../core/presentation/pages/changelog_page.dart';
import '../../../core/presentation/widgets/my_bottom_app_bar.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/my_icon.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../logic/service.dart';
import '../widgets/device_card.dart';
import '../widgets/refresh_button.dart';
import '../widgets/scanning_indicator.dart';

class _NoNetworkErrorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCard(
      highlight: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -.4,
                    ),
                    child: Text(
                      'Network Disabled',
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      letterSpacing: -.2,
                    ),
                    child: Text('Please check your connection settings'),
                  )
                ],
              ),
              Spacer(),
              MyIcon(
                icon: Icons.signal_wifi_off_rounded,
                color: Theme.of(context).colorScheme.error,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              onPressed: () => switch (OpenSettingsPlus.shared) {
                OpenSettingsPlusAndroid settings => settings.wifi(),
                OpenSettingsPlusIOS settings => settings.wifi(),
                _ => throw Exception('Platform not supported'),
              },
              child: Text('Open Network Settings'),
            ),
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
  final bool noNetwork;

  const _Loaded({
    Key? key,
    required this.onRefresh,
    required this.scanning,
    required this.devices,
    required this.noNetwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding + 8.0),
            child: CustomScrollView(
              slivers: [
                if (noNetwork)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _NoNetworkErrorCard(),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8),
                    child: Text(
                      'UPnP Devices',
                      style: TextTheme.of(context).titleMedium!.copyWith(
                            letterSpacing: -.2,
                          ),
                    ),
                  ),
                ),
                if (noNetwork && devices.isEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                        border: Border.all(
                            width: 1, color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),
                          Icon(Icons.troubleshoot,
                              size: 40, color: Theme.of(context).hintColor),
                          const SizedBox(height: 32),
                          Text(
                            'No Devices Found.',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'UPnP devices are unavailable while disconnected from the network.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                SliverImplicitlyAnimatedList<Device>(
                  items: devices,
                  insertDuration: Duration(milliseconds: 150),
                  removeDuration: Duration.zero,
                  itemBuilder: (context, animation, item, index) =>
                      FadeTransition(
                    opacity: animation,
                    child: DeviceCard(
                      device: item,
                    ),
                  ),
                  areItemsTheSame: (a, b) =>
                      a.description.udn == b.description.udn,
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ScanningIndicator(
              height: scanning ? 8 : 0,
            ),
          ),
        ),
      ],
    );
  }
}

class ExplorerPage extends StatefulWidget {
  final DiscoveryStateService _service;
  final ChangelogService _changelog;

  ExplorerPage({
    DiscoveryStateService? service,
    ChangelogService? changelog,
  })  : _service = service ?? sl<DiscoveryStateService>(),
        _changelog = changelog ?? sl<ChangelogService>();

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  @override
  void initState() {
    // TODO: Handle this as a dialog when the app starts
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
    final actions = [
      RefreshIconButton(
        service: widget._service,
      ),
    ];

    return Scaffold(
      bottomNavigationBar: MyBottomAppBar(
        currentIndex: 0,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: PageTitle(
          child: Row(
            children: [
              Icon(Icons.hub),
              SizedBox(width: 10),
              Text('Explorer'),
            ],
          ),
        ),
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

            print('scanning: ${snapshot.data!.scanning}');
            print('viableNetwork: ${snapshot.data!.viableNetwork}');

            return _Loaded(
              onRefresh: widget._service.search,
              scanning: snapshot.data!.scanning,
              devices: snapshot.data!.devices,
              noNetwork: !snapshot.data!.viableNetwork,
            );
          },
        ),
      ),
    );
  }
}
