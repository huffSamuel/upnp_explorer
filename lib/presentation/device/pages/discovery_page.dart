import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_settings/open_settings.dart';
import 'package:animated_list_plus/animated_list_plus.dart';
import '../../../packages/upnp/upnp.dart';

import '../../../application/application.dart';
import '../../../application/changelog/changelog_service.dart';
import '../../../application/ioc.dart';
import '../../../application/routing/routes.dart';
import '../../changelog/page/changelog_page.dart';
import '../../core/bloc/application_bloc.dart';
import '../../network_logs/pages/traffic_page.dart';
import '../widgets/device_list_item.dart';
import '../widgets/refresh_button.dart';
import '../widgets/scanning_indicator.dart';
import '../widgets/settings_icon_button.dart';

class _NoNetwork extends StatelessWidget {
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
            onPressed: () => OpenSettings.openWIFISetting(),
            child: Text(i18n.turnOnWifi),
          )
        ],
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<UPnPDevice> devices;
  final bool? scanning;

  const _Loaded({
    Key? key,
    required this.onRefresh,
    required this.scanning,
    required this.devices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (devices.length == 0 && scanning == false) {
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
          child: ImplicitlyAnimatedList<UPnPDevice>(
            items: devices,
            insertDuration: Duration(milliseconds: 150),
            removeDuration: Duration.zero,
            itemBuilder: (context, animation, item, index) => FadeTransition(
              opacity: animation,
              child: DeviceListItem(device: item),
            ),
            areItemsTheSame: (a, b) => a.document.udn == b.document.udn,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ScanningIndicator(
            height: scanning == true ? 8 : 0,
          ),
        ),
      ],
    );
  }
}

class DiscoveryPage extends StatefulWidget {
  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  final _bloc = sl<ApplicationBloc>();
  final _discovery = sl<UpnpDiscovery>();
  bool _scanning = true;
  List<UPnPDevice> _devices = [];

  _DiscoveryPageState();

  @override
  void initState() {
    super.initState();

    deviceEvents.listen((device) {
      setState(() {
        _devices.add(device);
      });
    });

    _discovery.start().then((_) => _discover());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkChangelog();
    });
  }

  void _checkChangelog() {
    sl<ChangelogService>().shouldDisplayChangelog().then((display) {
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

  Future<void> _discover() {
    setState(() {
      _scanning = true;
      _devices.clear();
    });

    return _discovery
        .search(
          searchTarget: SearchTarget.rootDevice(),
          locale: Platform.localeName.substring(0, 2),
        )
        .then(
          (_) => setState(() => _scanning = false),
        );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return BlocBuilder<ApplicationBloc, ApplicationState>(
      bloc: _bloc,
      buildWhen: (oldState, newState) => newState.build,
      builder: (context, state) {
        Widget body;

        if (state is Ready) {
          body = _Loaded(
            onRefresh: _discover,
            scanning: _scanning,
            devices: _devices,
          );
        } else if (state is NoNetwork) {
          body = _NoNetwork();
        } else {
          body = Container();
        }

        final actions = [
          IconButton(
            tooltip: i18n.viewNetworkTraffic,
            icon: const Icon(Icons.description_outlined),
            onPressed: () => Navigator.of(context).push(
              makeRoute(
                context,
                TrafficPage(),
              ),
            ),
          ),
          RefreshIconButton(
            onPressed: _scanning ? null : () => _discover(),
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            leading: const SettingsIconButton(),
            title: Text(Application.name),
            actions: actions,
          ),
          body: Center(
            child: Scrollbar(child: body),
          ),
        );
      },
    );
  }
}
