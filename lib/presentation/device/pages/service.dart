import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../packages/upnp/upnp.dart';
import 'state.dart';

@singleton
class DiscoveryStateService {
  final Connectivity _connectivity;
  final UpnpDiscovery _discovery;

  final _subject = BehaviorSubject<DiscoveryState>.seeded(
    DiscoveryState(
      devices: [],
    ),
  );
  final _destroying = PublishSubject();

  DiscoveryState get _value => _subject.value;
  Stream<DiscoveryState> get state => _subject.stream;

  DiscoveryStateService(
    this._connectivity,
    this._discovery,
  ) {
    // Start the discovery engine
    final d = _discovery.start().then((v) => true);

    // Check network connectivity
    final c = _connectivity.checkConnectivity().then(
          (v) => v == ConnectivityResult.wifi,
        );

    // When both complete, set the initial state and trigger the initial search
    Future.wait<bool>([d, c]).then((r) {
      _subject.add(_value.copyWith(
        loading: false,
        wifi: r[1],
      ));

      search();
    });

    // Whenever connectivity changes emit the new connectivity state
    _connectivity.onConnectivityChanged
        .map((event) => event == ConnectivityResult.wifi)
        .distinct()
        .takeUntil(_destroying)
        .listen((event) {
      if (event) {
        search();
      }
    });

    // Whenever new devices are emitted, add them to the state
    deviceEvents.takeUntil(_destroying).listen(
      (event) {
        _subject.add(
          _value.copyWith(
            devices: [
              ..._value.devices,
              event,
            ],
          ),
        );
      },
    );
  }

  Future<void> search() {
    if (!_value.wifi) {
      return Future.value();
    }

    _subject.add(_value.copyWith(
      devices: [],
      scanning: true,
    ));

    return _discovery
        .search(
          searchTarget: SearchTarget.rootDevice(),
          locale: Platform.localeName.substring(0, 2),
        )
        .then(
          (v) => _subject.add(
            _value.copyWith(scanning: false),
          ),
        );
  }

  void destroy() {
    _destroying.add(true);
    _destroying.close();
  }
}
