import 'command_status_field.dart';

class ActionResult {
  final CommandStatus status;
  final Duration? duration;
  final Map<String, String?>? results;
  final String? errorMessage;

  ActionResult({
    required this.status,
    required this.duration,
    required this.results,
    this.errorMessage,
  });
}
