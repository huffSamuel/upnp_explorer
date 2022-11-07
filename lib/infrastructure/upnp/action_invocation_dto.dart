import '../../domain/upnp/action_argument.dart';
import '../../domain/upnp/action_command.dart';

class ActionInvocationDto extends ActionInvocation {
  final String _urn;

  ActionInvocationDto(
    String actionName,
    String serviceType,
    String serviceVersion,
    List<ActionArgument> arguments,
  )   : _urn = 'urn:schemas-upnp-org:service:$serviceType:$serviceVersion',
        super(
          actionName,
          serviceType,
          serviceVersion,
          arguments,
        );

  factory ActionInvocationDto.fromDomain(ActionInvocation invocation) {
    return ActionInvocationDto(
      invocation.actionName,
      invocation.serviceType,
      invocation.serviceVersion,
      invocation.arguments,
    );
  }

  Map<String, String> get headers => {
        'CONTENT-LENGTH': body().length.toString(),
        'CONTENT-TYPE': 'text/xml; charset="utf-8"',
        'SOAPAction': '"$_urn#$actionName"',
      };

  String body() {
    final builder = StringBuffer('<?xml version="1.0"?>\r\n');

    // Open SOAP envelope
    builder.write(
        '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">');
    // Open SOAP body
    builder.write('<s:Body>');
    // Open Action
    builder.write('<u:$actionName xmlns:u="$_urn">');

    for (final argument in arguments) {
      builder.write('<${argument.name}>${argument.value}</${argument.name}>');
    }

    // Close Action
    builder.write('</u:$actionName>');
    // Close SOAP body
    builder.write('</s:Body>');
    // Close SOAP envelope
    builder.write("</s:Envelope>");

    return builder.toString();
  }
}
