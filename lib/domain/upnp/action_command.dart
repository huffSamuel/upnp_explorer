import 'action_argument.dart';

class ActionInvocation {
  final String actionName;
  final String serviceType;
  final String serviceVersion;
  final List<ActionArgument> arguments;

  ActionInvocation(
    this.actionName,
    this.serviceType,
    this.serviceVersion,
    this.arguments,
  ); 
}

