part of simple_upnp;

const _typeVariable = '{type}';
const _versionVariable = '{version}';
const _actionNameVariable = '{actionName}';
const _urnVariable = '{urn}';
const _paramsVariable = '{parameters}';

const _soapUrn =
    '''urn:schemas-upnp-org:service:$_typeVariable:$_versionVariable''';

const _soapBody =
    '''<?xml version="1.0"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><s:Body><u:$_actionNameVariable xmlns:u="$_urnVariable">$_paramsVariable</u:$_actionNameVariable></s:Body></s:Envelope>''';

const _soapHeaders = {'CONTENT-TYPE': 'text/xml; charset="utf-8"'};

class InvocationBindingContext {
  final Uri url;
  final ServiceDocument document;

  InvocationBindingContext({
    required this.url,
    required this.document,
  });

  Future<InvocationResponse> invoke(String name, Map<String, dynamic> args) {
    return SimpleUPNP.instance()._control.send(url, document, name, args);
  }
}

class ServiceControl {
  final StreamSink _events;
  final StaticOptions staticOptions;

  ServiceControl(
    StreamSink events,
    this.staticOptions,
  ) : _events = events;

  Future<void> stop() {
    return _events.close();
  }

  Future<InvocationResponse> send(
    Uri url,
    ServiceDocument document,
    String actionName,
    Map<String, dynamic> args,
  ) async {
    final controlUrl = Uri(
      scheme: url.scheme,
      host: url.host,
      port: url.port,
      path: document.controlUrl.path,
    );

    // TODO: Only allow arguments that are in the service document.
    var argList = args.keys
        .where((key) => args[key] != null)
        .map(
          (key) => '<$key>${args[key].toString()}</$key>',
        )
        .join('\n');

    final urn = replaceMany(_soapUrn, {
      _typeVariable: document.serviceType,
      _versionVariable: document.serviceVersion
    });

    final body = replaceMany(_soapBody, {
      _paramsVariable: argList,
      _actionNameVariable: actionName,
      _urnVariable: urn
    });

    final headers = {
      ..._soapHeaders,
      'CONTENT-LENGTH': body.length.toString(),
      'HOST': '${controlUrl.host}:${controlUrl.port}',
      'SOAPAction': '"$urn#$actionName"',
      'USER-AGENT':
          '${staticOptions.operatingSystem} ${staticOptions.userAgent}'
    };

    final response = await http.post(
      controlUrl,
      headers: headers,
      body: body,
    );

    _events.add(HttpRequestEvent(response));

    try {
      return InvocationResponse.parse(response.body);
    } catch (err) {
      final error = InvocationFault.parse(response.body);

      throw InvocationError(
        error.description,
        error.code,
      );
    }
  }
}
