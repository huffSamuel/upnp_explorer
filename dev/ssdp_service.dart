import 'dart:async';
import 'dart:io';

import 'package:upnp_explorer/application/network_logs/traffic_repository.dart';
import 'package:upnp_explorer/infrastructure/upnp/search_request_builder.dart';

import '../lib/application/settings/options.dart';
import '../lib/domain/network_logs/traffic.dart';
import '../lib/infrastructure/core/logger_factory.dart';
import '../lib/infrastructure/upnp/device_discovery_service.dart';
import '../lib/infrastructure/upnp/m_search_request.dart';
import '../lib/infrastructure/upnp/ssdp_response_message.dart';

const multicastAddress = '239.255.255.250';
const ssdpPort = 1900;
final defaultPort = 35502;
final InternetAddress ssdpV4Multicast = new InternetAddress(multicastAddress);

class SsdpService {
  SsdpService(
    LoggerFactory lf,
    this._networkLogs,
    this._builder,
  ) : _log = lf.build('SsdpService');

  final SearchRequestBuilder _builder;
  final _controller = StreamController<SSDPResponseMessage>.broadcast();
  final NetworkLogsRepository _networkLogs;
  final Logger _log;
  late ProtocolOptions _options;

  get devices => _controller.stream;

  final _sockets = <RawDatagramSocket>[];
  final _interfaces = <NetworkInterface>[];
  final _seen = <Uri>[];

  Completer? _completer;

  Future<void> search() {
    final message = _builder.build(maxResponseTime: _options.maxDelay);

    _completer?.complete();
    _completer = Completer();

    // Set up the periodic UDP search request
    Stream.periodic(Duration(seconds: 1)).take(_options.maxDelay).listen((index) {
      _sendSearchRequest(message);

      if(index == _options.maxDelay - 1) {
        _completer!.complete();
      }
    });

    return _completer!.future;
  }

  void _sendSearchRequest(MSearchRequest message) {
    for (final socket in _sockets) {
      _log.debug('Sending SSDP search message');

      try {
        socket.send(message.encode(), ssdpV4Multicast, ssdpPort);
        _networkLogs.add(
          Traffic<SearchRequest>(
            SearchRequest(
              message,
              '${socket.address.address}:${socket.port}',
            ),
            TrafficProtocol.ssdp,
            TrafficDirection.outgoing,
          ),
        );
      } on SocketException {
        _log.error('Socket exception');
      }
    }
  }

  void start() async {
    if (_sockets.isNotEmpty) {
      return;
    }

    _log.information('Starting SSDP service');

    _interfaces.addAll(await NetworkInterface.list());

    for (final interface in _interfaces) {
      await _createSocket(interface);
    }
  }

  Future<void> _createSocket(
    NetworkInterface interface,
  ) async {
    final socket = await RawDatagramSocket.bind(
      interface.addresses.first ?? InternetAddress.anyIPv4,
      0,
      reuseAddress: true,
      reusePort: false,
      ttl: _options.maxDelay + 3,
    )
      ..broadcastEnabled = true
      ..readEventsEnabled = true
      ..multicastHops = _options.hops;

    socket.listen((event) => _onSocketEvent(socket, event));

    try {
      socket.joinMulticast(ssdpV4Multicast);
    } catch (e) {
      _log.warning('Socket failed to join multicast group');
    }

    try {
      socket.joinMulticast(ssdpV4Multicast, interface);
    } catch (e) {
      _log.warning('Socket failed to join multicast group on interface');
    }

    _sockets.add(socket);
  }

  void _onSocketEvent(RawDatagramSocket socket, RawSocketEvent event) {
    Datagram? packet = socket.receive();

    if (packet == null) {
      return;
    }

    try {
      final message = SSDPResponseMessage.fromPacket(packet);
      _networkLogs.add(Traffic<SSDPResponseMessage>(
        message,
        TrafficProtocol.ssdp,
        TrafficDirection.incoming,
      ));

      if (_seen.contains(message.location)) {
        return;
      }

      _seen.add(message.location);

      _controller.add(message);
    } catch (e) {
      _log.error('Failed to decode packet');
    }
  }
}
