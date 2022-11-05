part of 'command_bloc.dart';

abstract class CommandEvent extends Equatable {
  const CommandEvent();

  @override
  List<Object> get props => [];
}

class SetDevice extends CommandEvent {
  final UPnPDevice device;

  SetDevice(this.device);

  @override
  List<Object> get props => [device];
}

class SetService extends CommandEvent {
  final Service service;

  SetService(this.service);

  @override
  List<Object> get props => [service];
}

class SendCommand extends CommandEvent {
  final Map<String, String?> arguments;
  final String actionName;

  SendCommand(this.arguments, this.actionName);

  @override
  List<Object> get props => [
        arguments,
        actionName,
      ];
}
