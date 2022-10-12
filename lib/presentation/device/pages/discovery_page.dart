import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_settings/open_settings.dart';

import '../../../application/application.dart';
import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/review/review_service.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/device/device.dart';
import '../../core/bloc/application_bloc.dart';
import '../../review/widgets/review_prompt_dialog.dart';
import '../../changelog/widgets/changelog_dialog.dart';
import '../bloc/discovery_bloc.dart';
import '../widgets/device-list-item.dart';
import '../widgets/refresh-button.dart';
import '../widgets/scanning-indicator.dart';
import '../widgets/settings-icon-button.dart';

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

class _Loaded extends StatefulWidget {
  final Future Function() onRefresh;

  const _Loaded({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<_Loaded> {
  final _bloc = sl<DiscoveryBloc>();

  bool? _isScanning;

  final List<UPnPDevice> _devices = [];
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    _bloc.discoverStream.listen((event) {
      setState(() {
        _isScanning = event;
        if (event) {
          _listKey = GlobalKey<AnimatedListState>();
          _devices.clear();
        }
      });
    });

    _bloc.deviceStream.listen((event) {
      if (_devices.contains(event)) {
        return;
      }

      _devices.add(event);
      _listKey.currentState?.insertItem(_devices.length - 1);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_devices.length == 0 && _isScanning == false) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).noDevicesFound,
          ),
        ),
      );
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: AnimatedList(
            key: _listKey,
            initialItemCount: 0,
            itemBuilder: (context, index, animation) => FadeTransition(
              opacity: animation.drive(
                Tween(
                  begin: 0.0,
                  end: 1.0,
                ),
              ),
              child: DeviceListItem(
                device: _devices[index],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ScanningIndicator(height: _isScanning == true ? 8 : 0),
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
  final _discoveryBloc = sl<DiscoveryBloc>();

  bool _scanning = false;

  @override
  void initState() {
    super.initState();

    _discoveryBloc.discoverStream.listen((scanning) => setState(() {
          _scanning = scanning;
        }));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      maybeShowChangelogDialog(context);
    });
  }

  Future _discover() {
    _discoveryBloc.discover();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ReviewRequested) {
          showDialog(context: context, builder: (ctx) => ReviewPromptDialog())
              .then(
            (response) {
              if (response == ReviewResponse.never) {
                _bloc.add(NeverReview());
              } else if (response == ReviewResponse.ok) {
                _bloc.add(ReviewNow());
              }
            },
          );
        } else if (state is Ready) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _discover();
          });
        }
      },
      buildWhen: (oldState, newState) => newState.build,
      builder: (context, state) {
        Widget body;

        if (state is Ready) {
          body = _Loaded(
            onRefresh: _discover,
          );
        } else if (state is NoNetwork) {
          body = _NoNetwork();
        } else {
          body = Container();
        }

        return Scaffold(
          appBar: AppBar(
            leading: SettingsIconButton(),
            title: Text(Application.name),
            actions: [
              IconButton(
                tooltip: 'View network traffic',
                icon: Icon(Icons.description_outlined),
                onPressed: () {
                  Application.router!.navigateTo(context, Routes.traffic);
                },
              ),
              RefreshIconButton(
                onPressed: _scanning ? null : () => _discover(),
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
