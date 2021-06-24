import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../../data/options.dart';
import '../../data/ssdp_request_message.dart';
import '../../data/ssdp_response_message.dart';
import 'logging/logger_factory.dart';
import 'ssdp_discovery.dart';

final InternetAddress ssdpV4Multicast = new InternetAddress(kMulticastAddress);

class DeviceDiscoveryService {
  set protocolOptions(ProtocolOptions options) {
    _protocolOptions = options;

    logger.context['hops'] = _protocolOptions.hops;
    logger.context['max_delay'] = _protocolOptions.maxDelay;
  }

  ProtocolOptions _protocolOptions;

  Completer _completer;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  final Logger logger;
  final address = InternetAddress.anyIPv4;
  final _servers = new StreamController<SSDPResponseMessage>.broadcast();

  DeviceDiscoveryService(LoggerFactory loggerFactory)
      : logger = loggerFactory.build('DeviceDiscoveryService');

  Stream<SSDPResponseMessage> get stream => _servers.stream;

  List<NetworkInterface> _interfaces;
  var _sockets = <RawDatagramSocket>[];

  Future<void> init() async {
    logger.information('Initializing discovery service');

    _interfaces = await NetworkInterface.list();

    return await _createSocket(
      SocketOptions(
        InternetAddress.anyIPv4,
        ssdpV4Multicast,
      ),
    );
  }

  _createSocket(SocketOptions options) async {
    var socket = await RawDatagramSocket.bind(
      address,
      0,
      reuseAddress: true,
      reusePort: defaultTargetPlatform != TargetPlatform.android,
    )
      ..broadcastEnabled = true
      ..readEventsEnabled = true
      ..multicastHops = _protocolOptions.hops;

    socket.listen((event) => _onSocketEvent(socket, event));

    for (var interface in _interfaces) {
      try {
        socket.joinMulticast(options.multicastAddress, interface);
      } catch (e) {
        logger.error('Unable to join multicast. $e');
      }
    }

    _sockets.add(socket);
  }

  void _onSocketEvent(RawDatagramSocket socket, RawSocketEvent event) {
    switch (event) {
      case RawSocketEvent.read:
        var packet = socket.receive();
        logger.debug('Response received from ${packet.address}');

        if (packet == null) {
          return;
        }

        var message = SSDPResponseMessage.fromPacket(packet);
        _servers.add(message);
        break;
      case RawSocketEvent.write:
        break;
      case RawSocketEvent.closed:
        logger.debug('Socket closed');
        break;
    }
  }

  Future search() {
    var msg = SSDPRequestMessage(
      maxResponseTime: _protocolOptions.maxDelay,
    );
    var data = msg.encode;

    for (var socket in _sockets) {
      logger.debug('Sending SSDP search message');
      final addr = ssdpV4Multicast;

      try {
        _completer = new Completer();
        socket.send(data, addr, kSsdpPort);
      } on SocketException {}
    }

    Future.delayed(
      Duration(seconds: _protocolOptions.maxDelay + 2),
    ).then((_) => stop());

    return _completer.future;
  }

  void stop() async {
    logger.debug('Closing sockets');
    for (var socket in _sockets) {
      socket.close();
    }

    _completer.complete();
    _servers.sink.addError('Done');
  }
}
