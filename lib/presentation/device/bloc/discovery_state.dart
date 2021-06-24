part of 'discovery_bloc.dart';

abstract class DiscoveryState extends Equatable {
  const DiscoveryState();

  @override
  List<Object> get props => [];
}

class DiscoveryInitial extends DiscoveryState {}

class NoNetwork extends DiscoveryState {}

class Loaded extends DiscoveryState {
  @override
  bool get stringify => true;

  final List<Device> devices;
  final bool isScanning;

  Loaded(this.devices, this.isScanning);

  Loaded copyWith({
    List<Device> devices,
    bool isScanning,
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
