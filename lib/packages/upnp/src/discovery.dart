part of upnp;

final InternetAddress v4Multicast = InternetAddress('239.255.255.250');
final InternetAddress v6Multicast = InternetAddress('FF05::C');

const port = 1900;

class Options {
  /// User agent of the current operating system.
  ///
  /// ### Example
  /// Android/33
  final String osUserAgent;

  /// Scan IPv4 addresses.
  final bool ipv4;

  /// Scan IPv6 addresses.
  final bool ipv6;

  /// Maximum network hops for multicast packages.
  final int multicastHops;

  // Maximum response delay.
  final int maxDelay;

  Options({
    this.ipv4 = true,
    this.ipv6 = true,
    this.multicastHops = 1,
    this.maxDelay = 1,
    required this.osUserAgent,
  });
}

class UpnpDiscovery {
  final List<String> _seen = [];
  final List<RawDatagramSocket> _sockets = [];

  String? _locale;

  Options _options;

  UpnpDiscovery(this._options);

  /// Update the options used to discover devices.
  Future<void> options(Options value) async {
    bool resetRequired = value.ipv4 != _options.ipv4 ||
        value.ipv6 != _options.ipv6 ||
        value.multicastHops != _options.multicastHops;

    _options = value;

    if (resetRequired) {
      for (final socket in _sockets) {
        socket.close();
      }

      await start();
    }
  }

  Future<void> start() async {
    if (_sockets.isNotEmpty) {
      return;
    }

    final interfaces = await NetworkInterface.list();

    await Future.wait([
      _createSocket(InternetAddress.anyIPv4, interfaces),
      _createSocket(InternetAddress.anyIPv6, interfaces),
    ]);
  }

  Future<void> search({
    required String searchTarget,
    String? locale,
  }) {
    _locale = locale ?? Platform.localeName.substring(0, 2);
    _seen.clear();

    final request = MSearchRequest(
        operatingSystem: _options.osUserAgent, mx: _options.maxDelay);
    final data = request.encode();
    final message = SearchRequest(request.toString());

    for (final socket in _sockets) {
      if (socket.address.type == v4Multicast.type) {
        try {
          socket.send(data, v4Multicast, port);
          _messageController.add(message);
        } on SocketException {}
      }

      if (socket.address.type == v6Multicast.type) {
        try {
          socket.send(data, v6Multicast, port);
          _messageController.add(message);
        } on SocketException {}
      }
    }

    return Future.delayed(
      Duration(
        seconds: _options.maxDelay + 1,
      ),
    );
  }

  Future<void> _createSocket(
    InternetAddress address,
    List<NetworkInterface> interfaces,
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

    try {
      socket.joinMulticast(v4Multicast);
    } on OSError {}

    try {
      socket.joinMulticast(v6Multicast);
    } on OSError {}

    for (var interface in interfaces) {
      try {
        socket.joinMulticast(v4Multicast, interface);
      } on OSError {}

      try {
        socket.joinMulticast(v6Multicast, interface);
      } on OSError {}
    }

    _sockets.add(socket);
  }

  _onSocketEvent(RawDatagramSocket socket, RawSocketEvent event) {
    final packet = socket.receive();

    if (packet == null) {
      return;
    }

    try {
      final client = Client.fromPacket(packet);
      if (_seen.contains(client.location!.authority)) {
        return;
      }

      _seen.add(client.location!.authority);
      _messageController.add(
        NotifyResponse(
          client.location!,
          client.toString(),
        ),
      );

      _getDeviceAggregate(
        client,
        _locale!,
      ).then((agg) {
        _deviceController.add(agg);
      });
    } catch (err) {}
  }

  Future<ServiceAggregate> _getService(
    Client client,
    Map<String, String> headers,
    ServiceDocument document,
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
      _messageController.add(
        HttpMessage(
          response,
        ),
      );
      final control = ServiceControl(
        document,
        client.location!,
        _options.osUserAgent,
      );

      service = Service.fromXml(
        XmlDocument.parse(
          response.body,
        ),
        control,
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
  ) async {
    final services = await Future.wait(
      device.services.map(
        (service) => _getService(
          client,
          headers,
          service,
        ),
      ),
    );

    final devices = await Future.wait(
      device.devices.map(
        (device) => _getDevice(
          client,
          device,
          headers,
        ),
      ),
    );

    return DeviceAggregate(
      device,
      services,
      devices,
    );
  }

  Future<UPnPDevice> _getDeviceAggregate(Client client, String locale) async {
    final headers = {'ACCEPT-LANGUAGE': locale};

    final response = await http.get(
      client.location!,
      headers: headers,
    );
    _messageController.add(
      HttpMessage(response),
    );
    final deviceDocument =
        XmlDocument.parse(response.body).rootElement.getElement('device');
    final device = DeviceDocument.fromXml(deviceDocument!);

    _getExtensions(response, deviceDocument);

    final aggregate = await _getDevice(
      client,
      device,
      headers,
    );

    return UPnPDevice(
      client,
      device,
      aggregate.services,
      aggregate.devices,
    );
  }

  Future<void> _getExtensions(http.Response response, XmlNode document) async {
    if (WakeOnLan.supportedBy(response, document)) {
      print('Supports wake on lan');
    }

    if (response.headers.containsKey('application-url')) {
      final dial = DialService(response.headers['application-url']!);
      http.get(Uri.parse(dial.url + 'YouTube')).then((r) {
        print(r.body);
        print(r.statusCode);
        print(r.headers);
      });
    }
  }
}
