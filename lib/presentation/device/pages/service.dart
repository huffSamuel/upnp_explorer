import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../libraries/simple_upnp/simple_upnp.dart';
import 'state.dart';

@singleton
class DiscoveryStateService {
  final Connectivity _connectivity;
  final SimpleUPNP _upnp;

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
    this._upnp,
  ) {
    SimpleUPNP.loadPredicate = (client) => _value.devices
        .where((element) => element.client.equals(client))
        .isEmpty;

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
        .skip(1)
        .distinct()
        .takeUntil(_destroying)
        .where((x) => x)
        .listen((x) => search());

    // Whenever new devices are emitted, add them to the state
    _upnp.discovered.takeUntil(_destroying).listen(
      (event) {
        if (_value.devices
            .where((d) => d.client.equals(event.client))
            .isNotEmpty) {
          return;
        }

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

    return _upnp.search(SearchTarget.rootDevice).then(
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
