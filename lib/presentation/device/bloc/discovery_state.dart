part of 'discovery_bloc.dart';

abstract class DiscoveryState extends Equatable {
  final bool build;
  const DiscoveryState({this.build = true});

  @override
  List<Object> get props => [];
}

class DiscoveryInitial extends DiscoveryState {}

class NoNetwork extends DiscoveryState {}

class Loaded extends DiscoveryState {
  @override
  bool get stringify => true;

  final List<UPnPDevice> devices;
  final bool isScanning;

  Loaded(this.devices, this.isScanning);

  Loaded copyWith({
    List<UPnPDevice>? devices,
    bool? isScanning,
  }) {
    return Loaded(
      devices ?? this.devices,
      isScanning ?? this.isScanning,
    );
  }

  @override
  List<Object> get props => [
        devices,
        isScanning,
      ];
}

class ReviewRequested extends DiscoveryState {
  ReviewRequested() : super(build: false);
}
