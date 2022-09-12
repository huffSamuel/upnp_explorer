import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:upnp_explorer/application/review/review_service.dart';

import '../../../domain/device/device.dart';
import '../../../infrastructure/ssdp/ssdp_discovery.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

@Singleton()
class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final SSDPService _discoveryService;
  final Connectivity _connectivity = Connectivity();
  final ReviewService _reviewService;

  StreamSubscription? _subscription;
  StreamSubscription? _connectivitySubscription;

  DiscoveryBloc(this._discoveryService, this._reviewService)
      : super(DiscoveryInitial()) {
    on<Discover>((event, emit) => _onDiscover(event, emit));
    on<StopDiscover>((event, emit) => _onStopDiscover(event, emit));
    on<_DeviceDiscovered>((event, emit) => _onDiscovered(event, emit));
    on<ReviewNow>((event, emit) => _onReviewNow());
    on<NeverReview>((event, emit) => _onNeverReview());

    add(Discover());

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  void _onReviewNow() {
    _reviewService.launchInAppReview();
  }

  void _onNeverReview() {
    _reviewService.neverAskAgain();
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _subscription?.cancel();
    return super.close();
  }

  void _onConnectivityChanged(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi && state is NoNetwork) {
      add(Discover());
    }
  }

  void _onDiscover(Discover event, Emitter<DiscoveryState> emit) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult != ConnectivityResult.wifi) {
      emit(NoNetwork());
      return;
    }

    emit(Loaded([], true));
    await _subscription?.cancel();
    _subscription = _discoveryService.findDevices().listen(
          (device) => add(_DeviceDiscovered(device)),
          onError: _onError,
        );
  }

  void _onError(dynamic error) {
    if (error == 'Done') {
      add(StopDiscover());
    }
  }

  void _onStopDiscover(StopDiscover event, Emitter<DiscoveryState> emit) async {
    if (state is Loaded) {
      var loaded = state as Loaded;

      emit(loaded.copyWith(
        isScanning: false,
      ));

      final isAvailable = await _reviewService.isAvailable();

      if (isAvailable) {
        emit(ReviewRequested());
      }
    }
  }

  void _onDiscovered(
      _DeviceDiscovered event, Emitter<DiscoveryState> emit) async {
    if (state is Loaded) {
      var loaded = state as Loaded;

      if (loaded.devices.contains(event.device)) {
        return;
      }

      var newState = loaded.copyWith(
        devices: [
          ...loaded.devices,
          event.device,
        ],
      );
      print(newState.devices.map((x) => x.ipAddress));

      emit(newState);
    }
  }
}
