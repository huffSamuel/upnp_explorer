import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../data/ssdp_request_message.dart';
import '../../data/ssdp_response_message.dart';
import 'ssdp_discovery.dart';

final InternetAddress ssdpV4Multicast = new InternetAddress("239.255.255.250");
final ssdpPort = 1900;

class DeviceDiscoveryService {
  Completer _completer;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  final address = InternetAddress.anyIPv4;
  final _servers = new StreamController<SSDPResponseMessage>.broadcast();

  Stream<SSDPResponseMessage> get stream => _servers.stream;

  List<NetworkInterface> _interfaces;
  var _sockets = <RawDatagramSocket>[];

  Future<void> init() async {
    _interfaces = await NetworkInterface.list();

    return await _createSocket(
      SocketOptions(
        InternetAddress.anyIPv4,
        ssdpV4Multicast,
      ),
    );
  }

  _createSocket(SocketOptions options) async {
    var socket = await RawDatagramSocket.bind(address, 0,
        reuseAddress: true,
        reusePort: defaultTargetPlatform != TargetPlatform.android)
      ..broadcastEnabled = true
      ..readEventsEnabled = true
      ..multicastHops = 25;
    //..setRawOption(options.socketOption);

    socket.listen((event) => _onSocketEvent(socket, event));

    for (var interface in _interfaces) {
      try {
        socket.joinMulticast(options.multicastAddress, interface);
      } catch (e) {
        print(e);
      }
    }

    _sockets.add(socket);
  }

  void _onSocketEvent(RawDatagramSocket socket, RawSocketEvent event) {
    switch (event) {
      case RawSocketEvent.read:
        var packet = socket.receive();
        print(packet.address);

        if (packet == null) {
          return;
        }

        var message = SSDPResponseMessage.fromPacket(packet);
        _servers.add(message);
        break;
      case RawSocketEvent.write:
        break;
      case RawSocketEvent.closed:
        print('closed');
        break;
    }
  }

  Future search() {
    var msg = SSDPRequestMessage();
    var data = msg.encode;

    for (var socket in _sockets) {
      final addr = ssdpV4Multicast;

      try {
        _completer = new Completer();
        socket.send(data, addr, ssdpPort);
      } on SocketException {}
    }

    Future.delayed(Duration(seconds: 30)).then((_) => stop());

    return _completer.future;
  }

  void stop() async {
    for (var socket in _sockets) {
      socket.close();
    }

    _completer.complete();
  }
}
