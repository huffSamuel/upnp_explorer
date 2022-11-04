import 'action_argument.dart';

class ActionResponse {
  final String actionName;
  final List<ActionArgument> arguments;

  ActionResponse(
    this.actionName,
    this.arguments,
  );
}
