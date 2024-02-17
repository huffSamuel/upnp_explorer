part of simple_upnp;

final InternetAddress _v4Multicast = InternetAddress('239.255.255.250');
final InternetAddress _v6Multicast = InternetAddress('FF05::C');

const _ssdpPort = 1900;
const _anyPort = 0;

const _defaultSearchTarget = SearchTarget.rootDevice;
const _defaultMx = 1;

const _mxVariable = '{mx}';
const _stVariable = '{st}';
const _osVariable = '{os}';
const _userAgentVariable = '{ua}';

const _msearch = """
M-SEARCH * HTTP/1.1\r
HOST: 239.255.255.250:1900\r
MAN: "ssdp:discover"\r
MX: $_mxVariable\r
ST: $_stVariable\r
USER-AGENT: $_osVariable UPnP/1.1 ${_userAgentVariable}\r
\r
""";

class MSearchRequest {
  final String _message;

  MSearchRequest({
    required String operatingSystem,
    required String userAgent,
    String st = _defaultSearchTarget,
    mx = _defaultMx,
  }) : _message = replaceMany(_msearch, {
          _osVariable: operatingSystem,
          _stVariable: st,
          _mxVariable: mx,
          _userAgentVariable: userAgent,
        });

  @override
  String toString() {
    return _message;
  }

  List<int> encode() => utf8.encode(_message);
}

class SSDPDiscovery {
  late Options _options;

  final StreamSink _events;
  final StaticOptions staticOptions;

  final StreamController<Client> _notify = StreamController();
  final List<RawDatagramSocket> _sockets = [];

  Stream<Client> get notify => _notify.stream;

  SSDPDiscovery(StreamSink events, this.staticOptions) : _events = events;

  Future<void> start(Options options) async {
    if (_sockets.isNotEmpty) {
      return;
    }

    _options = options;
    final interfaces = await NetworkInterface.list();

    await Future.wait([
      _createSocket(
        InternetAddress.anyIPv4,
        interfaces,
        _ssdpPort,
      ),
      _createSocket(
        InternetAddress.anyIPv6,
        interfaces,
        _ssdpPort,
      ),
      _createSocket(
        InternetAddress.anyIPv4,
        interfaces,
        _anyPort,
      ),
      _createSocket(
        InternetAddress.anyIPv6,
        interfaces,
        _anyPort,
      ),
    ]);
  }

  Future<void> stop() async {
    _sockets.forEach((element) {
      element.close();
    });

    await Future.wait([
      _events.close(),
      _notify.close(),
    ]);
  }

  void search({
    required String searchTarget,
    String? locale,
  }) async {
    final request = MSearchRequest(
      operatingSystem: staticOptions.operatingSystem,
      userAgent: staticOptions.userAgent,
      mx: _options.maxDelay,
    );
    final data = request.encode();

    for (final socket in _sockets) {
      if (socket.address.type == _v4Multicast.type) {
        try {
          socket.send(data, _v4Multicast, _ssdpPort);
          _events.add(SearchEvent.send(
            request.toString(),
          ));
        } on SocketException {}
      }

      if (socket.address.type == _v6Multicast.type) {
        try {
          socket.send(data, _v6Multicast, _ssdpPort);
          _events.add(SearchEvent.send(
            request.toString(),
          ));
        } on SocketException {}
      }
    }
  }

  Future<void> _createSocket(
    InternetAddress address,
    List<NetworkInterface> interfaces,
    int port,
  ) async {
    final socket = await RawDatagramSocket.bind(
      address,
      port,
      reuseAddress: true,
      reusePort: !Platform.isAndroid,
    )
      ..broadcastEnabled = true
      ..readEventsEnabled = true
      ..writeEventsEnabled = false
      ..multicastLoopback = false
      ..multicastHops = _options.multicastHops;

    socket.listen((event) => _onSocketEvent(socket, event));

    final multicast = address.type == InternetAddress.anyIPv4.type
        ? _v4Multicast
        : _v6Multicast;

    var success = false;

    for (var interface in [null, ...interfaces]) {
      try {
        socket.joinMulticast(multicast, interface);
        success = true;
      } on OSError {}
    }

    if (success) {
      _sockets.add(socket);
    } else {
      socket.close();
    }
  }

  void _onSocketEvent(
    RawDatagramSocket socket,
    RawSocketEvent event,
  ) {
    final packet = socket.receive();

    if (packet == null) {
      return;
    }

    final message = utf8.decode(packet.data);

    if (message.contains('M-SEARCH')) {
      _events.add(SearchEvent.receive(message, packet.address));
    } else {
      try {
        final client = Client.fromPacket(packet);

        _notify.add(client);
        _events.add(NotifyEvent(
          client.location!.host,
          client.toString(),
        ));
      } catch (err) {
        // TODO: This is an invalid notify response? Maybe?
        print('Unable to decode notify packet\r\n$err');
      }
    }
  }
}

class Discovery {
  final StreamSink _events;
  final SSDPDiscovery _ssdp;
  final StaticOptions options;

  Discovery(
    StreamSink events,
    this.options,
    SSDPDiscovery ssdp,
  )   : _events = events,
        _ssdp = ssdp;

  Stream<UPnPDevice> get discovered => _ssdp.notify
          .where((e) => SimpleUPNP.loadPredicate(e))
          .asyncMap((event) => _loadAggregate(event, 'en-us', 'unknown'))
          .doOnError((e, s) {
        print('Unable to map to aggregate\r\n$e\r\n$s');
      });

  void search(String searchTarget) {
    return _ssdp.search(searchTarget: searchTarget);
  }

  Future<void> start(Options options) async {
    await _ssdp.start(options);
  }

  Future<void> stop() async {
    await _ssdp.stop();
  }

  Future<UPnPDevice> _loadAggregate(
    Client client,
    String locale,
    String userAgent,
  ) async {
    final headers = {'ACCEPT-LANGUAGE': locale};

    final response = await http.get(
      client.location!,
      headers: headers,
    );
    _events.add(HttpRequestEvent(response));
    final deviceDocument =
        XmlDocument.parse(response.body).rootElement.getElement('device');
    final device = DeviceDocument.fromXml(deviceDocument!);

    final aggregate = await _getDevice(
      client,
      device,
      headers,
      userAgent,
    );

    return UPnPDevice(
      client,
      device,
      aggregate.services,
      aggregate.devices,
    );
  }

  Future<ServiceAggregate> _getService(
    Client client,
    Map<String, String> headers,
    ServiceDocument document,
    String userAgent,
  ) async {
    final uri = Uri(
      scheme: client.location!.scheme,
      host: client.location!.host,
      port: client.location!.port,
      pathSegments: document.scpdurl.pathSegments,
    );

    Service? service;

    try {
      final response = await http.get(uri, headers: headers);
      _events.add(HttpRequestEvent(response));

      service = Service.fromXml(
        XmlDocument.parse(
          response.body,
        ),
        InvocationBindingContext(
          url: client.location!,
          document: document,
        ),
      );
    } catch (err) {
      service = null;
    }

    return ServiceAggregate(
      document,
      service,
      uri,
    );
  }

  Future<DeviceAggregate> _getDevice(
    Client client,
    DeviceDocument device,
    Map<String, String> headers,
    String userAgent,
  ) async {
    final services = await Future.wait(
      device.services.map(
        (service) => _getService(client, headers, service, userAgent),
      ),
    );

    final devices = await Future.wait(
      device.devices.map(
        (device) => _getDevice(
          client,
          device,
          headers,
          userAgent,
        ),
      ),
    );

    return DeviceAggregate(
      device,
      services,
      devices,
    );
  }
}
