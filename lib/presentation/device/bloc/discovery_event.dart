part of 'discovery_bloc.dart';

abstract class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();

  @override
  List<Object> get props => [];
}

class Discover extends DiscoveryEvent {}

class StopDiscover extends DiscoveryEvent {}

class _DeviceDiscovered extends DiscoveryEvent {
  final Device device;

  _DeviceDiscovered(this.device);

  @override
  List<Object> get props => [device];
}
