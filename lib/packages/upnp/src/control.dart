part of upnp;

const _soapUrn = '''urn:schemas-upnp-org:service:{type}:{version}''';

const _soapBody =
    '''<?xml version="1.0"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><s:Body><u:{actionName} xmlns:u="{urn}">{parameters}</u:{actionName}></s:Body></s:Envelope>''';

const _soapHeaders = {'CONTENT-TYPE': 'text/xml; charset="utf-8"'};

class ActionResponse {
  final String actionName;
  final Map<String, String> arguments;

  ActionResponse(
    this.actionName,
    this.arguments,
  );

  factory ActionResponse.parse(String str) {
    final Map<String, String> arguments = {};
    final xml = XmlDocument.parse(str);
    final node =
        xml.rootElement.getElement('s:Body')!.children.firstWhere((el) => el is XmlElement) as XmlElement;

    if (node.localName == "Fault") {
      throw "Parse the fault with ActionFault";
    }

    node.children.whereType<XmlElement>().forEach(
          (x) => arguments[x.localName] = x.innerText,
        );

    return ActionResponse(
      node.localName.replaceAll('Response', ''),
      arguments,
    );
  }
}

class ActionFault {
  final String code;
  final String description;

  ActionFault(
    this.code,
    this.description,
  );

  factory ActionFault.parse(String str) {
    final xml = XmlDocument.parse(str);
    final node = xml.rootElement
        .getElement('s:Body')!
        .getElement('s:Fault')!
        .getElement('detail')!
        .getElement('UPnPError')!;

    final code = node.getElement('errorCode')!.innerText;
    final description = node.getElement('errorDescription')!.innerText;

    return ActionFault(code, description);
  }
}

class ServiceControl {
  final String operatingSystem;
  final ServiceDocument document;
  final Uri address;

  ServiceControl(this.document, this.address, this.operatingSystem);

  Uri get _controlUrl => Uri(
        scheme: address.scheme,
        host: address.host,
        port: address.port,
        path: document.controlUrl.path,
      );

  Future<ActionResponse> send(
      String actionName, Map<String, dynamic> args) async {
    var argList = args.keys.where((key) => args[key] != null).map(
      (key) {
        return '<$key>${args[key].toString()}</$key>';
      },
    ).join('\n');

    final urn = _soapUrn
        .replaceAll('{type}', document.serviceType)
        .replaceAll('{version}', document.serviceVersion);

    var body = _soapBody
        .replaceAll('{parameters}', argList)
        .replaceAll('{actionName}', actionName)
        .replaceAll('{urn}', urn);

    var headers = {
      ..._soapHeaders,
      'CONTENT-LENGTH': body.length.toString(),
      'HOST': '${_controlUrl.host}:${_controlUrl.port}',
      'SOAPAction': '"$urn#$actionName"',
      'USER-AGENT': '$operatingSystem upnp_cnc/1.0'
    };

    final response = await http.post(
      _controlUrl,
      headers: headers,
      body: body,
    );

    _messageController.add(
      HttpMessage(
        response,
      ),
    );

    try {
      return ActionResponse.parse(response.body);
    } catch (err) {
      final error = ActionFault.parse(response.body);

      throw ActionInvocationError(
        error.description,
        error.code,
      );
    }
  }
}
