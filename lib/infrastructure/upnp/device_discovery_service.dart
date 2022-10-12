import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:upnp_explorer/infrastructure/upnp/search_request_builder.dart';
import '../../application/device/traffic_repository.dart';

import '../../application/settings/options.dart';
import '../core/logger_factory.dart';
import 'm_search_request.dart';
import 'ssdp_response_message.dart';
import 'ssdp_discovery.dart';

const multicastAddress = '239.255.255.250';
const ssdpPort = 1900;
final defaultPort = 35502;
final InternetAddress ssdpV4Multicast = new InternetAddress(multicastAddress);

@Singleton()
class DeviceDiscoveryService {
  set protocolOptions(ProtocolOptions options) {
    _protocolOptions = options;

    logger.context['hops'] = _protocolOptions.hops;
    logger.context['max_delay'] = _protocolOptions.maxDelay;
  }

  late ProtocolOptions _protocolOptions;

  Completer _completer = Completer();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  List<NetworkInterface> _interfaces = [];

  Stream<SearchMessage> get responses => _servers.stream;

  var _sockets = <RawDatagramSocket>[];

  final Logger logger;
  final address = InternetAddress.anyIPv4;
  final TrafficRepository trafficRepository;
  final SearchRequestBuilder requestBuilder;
  late StreamController<SearchMessage> _servers;

  DeviceDiscoveryService(
    LoggerFactory loggerFactory,
    this.trafficRepository,
    this.requestBuilder,
  ) : logger = loggerFactory.build('DeviceDiscoveryService');

  Future<void> init() async {
    if (_sockets.isNotEmpty) {
      return;
    }

    logger.information('Initializing discovery service');
    _servers = new StreamController<SearchMessage>.broadcast();
    final allInterfaces = await NetworkInterface.list();
    _interfaces = allInterfaces.where((x) => x.name.contains('w')).toList();

    for (final interface in _interfaces) {
      await _createSocket(
        SocketOptions(
          interface,
          ssdpV4Multicast,
        ),
      );
    }
  }

  _createSocket(SocketOptions options) async {
    final socket = await RawDatagramSocket.bind(
      options.interface.addresses.first,
      0,
      reuseAddress: true,
      reusePort: false,
      ttl: _protocolOptions.maxDelay + 3,
    )
      ..broadcastEnabled = true
      ..readEventsEnabled = true
      ..multicastHops = _protocolOptions.hops;

    socket.listen((event) => _onSocketEvent(socket, event));

    try {
      socket.joinMulticast(ssdpV4Multicast);
    } catch (e) {
      logger.error('Unable to join multicast. $e');
    }

    for (var interface in _interfaces) {
      try {
        socket.joinMulticast(ssdpV4Multicast, interface);
      } catch (e) {
        print('Unable to join multicast');
      }
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
      trafficRepository.add(
        Traffic<SSDPResponseMessage>(
          message,
          TrafficProtocol.ssdp,
          TrafficDirection.incoming,
        ),
      );
      _servers.add(DeviceFound(message));
    } catch (err) {
      print('Failure decoding message from packet');
    }
  }

  Future search() async {
    final msg =
        requestBuilder.build(maxResponseTime: _protocolOptions.maxDelay);

    var data = msg.encode();

    Stream.periodic(Duration(seconds: 1))
        .take(_protocolOptions.maxDelay)
        .listen((_) {
      for (var socket in _sockets) {
        logger.debug('Sending SSDP search message');
        final addr = ssdpV4Multicast;

        try {
          _completer = new Completer();
          socket.send(data, addr, ssdpPort);
          trafficRepository.add(
            Traffic<SearchRequest>(
              SearchRequest(
                msg,
                socket.address.address + ':' + socket.port.toString(),
              ),
              TrafficProtocol.ssdp,
              TrafficDirection.outgoing,
            ),
          );
        } on SocketException {
          print('Socket exception');
        }
      }
    });

    Future.delayed(
      Duration(seconds: _protocolOptions.maxDelay + 2),
    ).then((_) => stop());

    return _completer.future;
  }

  void stop() async {
    _completer.complete();
    _servers.sink.add(SearchComplete());
  }
}

class SearchRequest {
  final MSearchRequest request;
  final String address;

  SearchRequest(this.request, this.address);
}

abstract class SearchMessage {}

class SearchComplete extends SearchMessage {}

class DeviceFound extends SearchMessage {
  final SSDPResponseMessage message;

  DeviceFound(this.message);
}
