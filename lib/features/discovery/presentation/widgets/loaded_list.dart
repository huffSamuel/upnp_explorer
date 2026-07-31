import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart' show Device;

import '../../../../extension/build_context.dart';
import 'device_card.dart';
import 'no_network_card.dart';
import 'scanning_indicator.dart';

class LoadedList extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Device> devices;
  final bool scanning;
  final bool noNetwork;

  const LoadedList({
    super.key,
    required this.onRefresh,
    required this.scanning,
    required this.devices,
    required this.noNetwork,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();
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
                      child: NoNetworkErrorCard(),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8),
                    child: Text(
                      i18n.upnpDevices,
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
                            i18n.noDevicesFound,
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            i18n.devicesUnavailableWhenNoNetwork,
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
