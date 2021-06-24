import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_settings/open_settings.dart';

import '../../../constants.dart';
import '../../../domain/device.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/services/ioc.dart';
import '../bloc/discovery_bloc.dart';
import '../widgets/device-list-item.dart';
import '../widgets/refresh-button.dart';
import '../widgets/scanning-indicator.dart';
import '../widgets/settings-icon-button.dart';
import 'device-page.dart';

class _NoNetwork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

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
  final Loaded state;

  const _Loaded({Key key, this.state}) : super(key: key);

  Widget _makeElement(Device device, Function onTap) {
    return DeviceListItem(
      device: device,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    if (state.isScanning) {
      children.add(ScanningIndicator(height: 7));
    }

    children.addAll(state.devices.map(
      (e) => _makeElement(
        e,
        (device) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => PageView.builder(
              itemCount: state.devices.length,
              controller:
                  PageController(initialPage: state.devices.indexOf(device)),
              itemBuilder: (context, index) => DevicePage(
                device: device,
              ),
            ),
          ),
        ),
      ),
    ));

    if (children.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(S.of(context).noDevicesFound),
        ),
      );
    }
    return ListView(children: children);
  }
}

class DiscoveryPage extends StatelessWidget {
  final _bloc = sl<DiscoveryBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoveryBloc, DiscoveryState>(
      bloc: _bloc,
      builder: (context, state) {
        bool _scanning = state is Loaded && state.isScanning;

        Widget body;

        if (state is Loaded) {
          body = _Loaded(state: state);
        } else if (state is NoNetwork) {
          body = _NoNetwork();
        } else {
          body = Container();
        }

        return Scaffold(
          appBar: AppBar(
            leading: SettingsIconButton(),
            title: Text(kAppName),
            actions: [
              RefreshIconButton(
                onPressed: _scanning ? null : () => _bloc.add(Discover()),
              ),
            ],
          ),
          body: Center(
            child: Scrollbar(child: body),
          ),
        );
      },
    );
  }
}
