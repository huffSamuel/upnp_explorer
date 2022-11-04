part of 'device_bloc.dart';

class DeviceState extends Equatable {
  final UPnPDevice? device;
  final Service? service;

  DeviceState({this.device, this.service});

  DeviceState copyWith({
    UPnPDevice? device,
    Service? service,
  }) {
    return DeviceState(
      device: device ?? this.device,
      service: service ?? this.service,
    );
  }

  @override
  List<Object> get props => [
        if (device != null) device!,
        if (service != null) service!,
      ];
}

class ActionSuccess extends DeviceState {
  final List<ActionArgument> data;

  ActionSuccess(this.data);

  @override
  List<Object> get props => [
        ...super.props,
      ];
}
