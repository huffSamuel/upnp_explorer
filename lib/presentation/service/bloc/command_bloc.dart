import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../application/ioc.dart';
import '../../../domain/device/device.dart';
import '../../../domain/upnp/action_argument.dart';
import '../../../domain/upnp/action_command.dart';
import '../../../domain/upnp/error.dart';
import '../../../infrastructure/upnp/models/device.dart';
import '../../../infrastructure/upnp/soap_service.dart';

part 'command_event.dart';
part 'command_state.dart';

@singleton
class CommandBloc extends Bloc<CommandEvent, CommandState> {
  final SoapService soap;

  CommandBloc(this.soap) : super(CommandState()) {
    on<SetDevice>(_onSetDevice);
    on<SetService>(_onSetService);
    on<SendCommand>(_onSendCommand);
  }

  _onSetDevice(SetDevice event, Emitter<CommandState> emit) {
    emit(state.copyWith(device: event.device));
  }

  _onSetService(SetService event, Emitter<CommandState> emit) {
    emit(state.copyWith(service: event.service));
  }

  _onSendCommand(SendCommand event, Emitter<CommandState> emit) async {
    if (state.service == null || state.device == null) {
      return;
    }

    final current = state;
    final invocation = ActionInvocation(
      event.actionName,
      state.service!.serviceType,
      state.service!.serviceVersion,
      event.arguments,
    );
    final soap = sl<SoapService>();

    final ipAddress = state.device!.discoveryResponse.location;
    final uri = Uri(
      scheme: ipAddress.scheme,
      host: ipAddress.host,
      port: ipAddress.port,
      path: state.service!.controlUrl.path,
    );

    try {
      final response = await soap.send(uri, invocation);
      emit(ActionSuccess(response.arguments));
      emit(current);
    } catch (error) {
      if(error is ActionInvocationError) {
        // TODO: Do something with this error
      }
    }
  }
}
