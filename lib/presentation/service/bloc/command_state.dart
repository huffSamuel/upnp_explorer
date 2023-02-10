part of 'command_bloc.dart';

class CommandState extends Equatable {
  final UPnPDevice? device;
  final Service? service;

  CommandState({this.device, this.service});

  CommandState copyWith({
    UPnPDevice? device,
    Service? service,
  }) {
    return CommandState(
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

class ActionSuccess extends CommandState {
  final List<ActionArgument> data;

  ActionSuccess(this.data);

  @override
  List<Object> get props => [
        ...super.props,
      ];
}

class ActionFault extends CommandState {
  final String code;
  final String description;

  ActionFault(this.code, this.description);
}
