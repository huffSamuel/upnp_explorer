import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/device.dart';
import '../../../domain/rules/add-device-rule.dart';
import '../../../infrastructure/services/ssdp_discovery.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final SSDPService _discoveryService;
  final AddDeviceRule _addDeviceRule = new AddDeviceRule();
  final Connectivity _connectivity = Connectivity();

  StreamSubscription _subscription;
  StreamSubscription _connectivitySubscription;

  DiscoveryBloc(this._discoveryService) : super(DiscoveryInitial()) {
    add(Discover());

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _subscription.cancel();
    return super.close();
  }

  void _onConnectivityChanged(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi && state is NoNetwork) {
      add(Discover());
    }
  }

  @override
  Stream<DiscoveryState> mapEventToState(
    DiscoveryEvent event,
  ) async* {
    if (event is Discover) {
      yield* _mapDiscoverToState(event);
    } else if (event is _DeviceDiscovered) {
      yield* _mapDeviceDiscoveredToState(event);
    } else if (event is StopDiscover) {
      yield* _mapStopDiscoverToState(event);
    }
  }

  Stream<DiscoveryState> _mapDiscoverToState(Discover event) async* {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult != ConnectivityResult.wifi) {
      yield NoNetwork();
      return;
    }

    yield Loaded([], true);
    await _subscription?.cancel();
    _subscription = _discoveryService.findDevices().listen(
          _onDeviceDiscovered,
          onError: _onError,
        );
  }

  void _onDeviceDiscovered(Device device) {
    add(_DeviceDiscovered(device));
  }

  void _onError(dynamic error) {
    if (error == 'Done') {
      add(StopDiscover());
    }
  }

  Stream<DiscoveryState> _mapStopDiscoverToState(StopDiscover event) async* {
    if (state is Loaded) {
      var loaded = state as Loaded;

      yield loaded.copyWith(
        isScanning: false,
      );
    }
  }

  Stream<DiscoveryState> _mapDeviceDiscoveredToState(
    _DeviceDiscovered event,
  ) async* {
    if (state is Loaded) {
      var loaded = state as Loaded;

      if (!_addDeviceRule.execute(event.device, loaded.devices)) {
        return;
      }

      var newState = loaded.copyWith(
        devices: [
          ...loaded.devices,
          event.device,
        ],
      );

      yield newState;
    }
  }
}
