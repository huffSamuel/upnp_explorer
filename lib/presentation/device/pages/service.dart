import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:upnped/upnped.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../application/settings/options.dart';
import 'state.dart';

@singleton
class DiscoveryStateService {
  final Connectivity _connectivity;
  final Server _upnp;

  final _subject = BehaviorSubject<DiscoveryState>.seeded(
    DiscoveryState(
      devices: [],
    ),
  );
  final _destroying = PublishSubject();

  ProtocolSettings _settings = ProtocolSettings();

  DiscoveryState get _value => _subject.value;
  Stream<DiscoveryState> get state => _subject.stream;

  DiscoveryStateService(
    this._connectivity,
    this._upnp,
  ) {
    _upnp.loadPredicate = (NotifyDiscovered client) {
      return _value.devices
          .where((element) => element.notify!.location == client.location)
          .isEmpty;
    };

    // Check network connectivity
    _connectivity.checkConnectivity().then((v) {
      final wifi = v == ConnectivityResult.wifi;

      _subject.add(_value.copyWith(
        loading: false,
        wifi: wifi,
      ));

      search();
    });

    // Whenever connectivity changes emit the new connectivity state
    _connectivity.onConnectivityChanged
        .map((event) => event == ConnectivityResult.wifi)
        .distinct()
        .takeUntil(_destroying)
        .where((x) => x)
        .skip(1)
        .listen((x) {
      search();
    });

    // Whenever new devices are emitted, add them to the state
    _upnp.devices.takeUntil(_destroying).listen(
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

  Future<void> update(ProtocolSettings settings) async {
    _settings = settings;
    await _upnp.stop();
    await _upnp.listen(Options(
      multicastHops: settings.hops,
    ));
  }

  Future<void> search() {
    if (!_value.wifi) {
      return Future.value();
    }

    _subject.add(_value.copyWith(
      devices: [],
      scanning: true,
    ));

    return _upnp
        .search(
          maxResponseTime: Duration(seconds: _settings.maxDelay),
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
