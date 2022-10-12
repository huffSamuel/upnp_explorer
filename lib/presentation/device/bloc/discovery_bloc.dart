import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../domain/device/device.dart';
import '../../../infrastructure/upnp/ssdp_discovery.dart';

@Singleton()
class DiscoveryBloc {
  final SSDPService _discoveryService;

  DiscoveryBloc(this._discoveryService);

  final _deviceStreamController = StreamController<UPnPDevice>.broadcast();
  final _discoveringStreamController = StreamController<bool>.broadcast();

  Stream<UPnPDevice> get deviceStream => _deviceStreamController.stream;
  Stream<bool> get discoverStream => _discoveringStreamController.stream;

  StreamSubscription? _subscription;

  _done() {
    _discoveringStreamController.add(false);
  }

  void discover() {
    _subscription?.cancel();
    _discoveringStreamController.add(true);
    _subscription = _discoveryService.findDevices().listen(
      (device) {
        _deviceStreamController.add(device);
      },
      onDone: () => _done(),
      onError: (err) => _done(),
    );
  }
}
