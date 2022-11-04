part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class SetDevice extends DeviceEvent {
  final UPnPDevice device;

  SetDevice(this.device);

  @override
  List<Object> get props => [device];
}

class SetService extends DeviceEvent {
  final Service service;

  SetService(this.service);

  @override
  List<Object> get props => [service];
}

class SendCommand extends DeviceEvent {
  final Map<String, String?> arguments;
  final String actionName;

  SendCommand(this.arguments, this.actionName);

  @override
  List<Object> get props => [
        arguments,
        actionName,
      ];
}
