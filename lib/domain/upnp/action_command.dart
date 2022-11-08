class ActionInvocation {
  final String _urn;

  final String actionName;
  final String serviceType;
  final String serviceVersion;
  final Map<String, String?> arguments;

  ActionInvocation(
    this.actionName,
    this.serviceType,
    this.serviceVersion,
    this.arguments,
  ) : _urn = 'urn:schemas-upnp-org:service:$serviceType:$serviceVersion';

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

    arguments.forEach((key, value) {
      if (value != null) {
        builder.write('<$key>$value</$key>');
      }
    });

    // Close Action
    builder.write('</u:$actionName>');
    // Close SOAP body
    builder.write('</s:Body>');
    // Close SOAP envelope
    builder.write("</s:Envelope>");

    return builder.toString();
  }
}
