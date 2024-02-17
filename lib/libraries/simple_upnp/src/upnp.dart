library simple_upnp;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:xml/xml.dart';
import 'util/replace_many.dart';

part 'device/client.dart';
part 'device/device.dart';
part 'device/extensions/dial.dart';
part 'device/extensions/wake_on_lan.dart';
part 'discovery.dart';
part 'error/action_invocation_error.dart';
part 'messages.dart';
part 'options.dart';
part 'search_target.dart';
part 'soap/control.dart';
part 'soap/fault.dart';
part 'soap/response.dart';

enum State {
  uninitialized,
  ready,
  searching,
}

/// A simple UPNP server for discovering and controlling UPNP devices on a network.
class SimpleUPNP {
  /// Predicate the discovery service uses to determine if additional device data
  /// should be loaded.
  ///
  /// This will typically be used to ignore any duplicate NOTIFY events triggered by some
  /// other M-SEARCH request or to ignore UPnP client implementations that respond with a
  /// NOTIFY per child device.
  static var loadPredicate = (Client client) => true;

  static SimpleUPNP? _instance;

  /// The global instance of the SimpleUPNP server.
  static SimpleUPNP instance() {
    return _instance ??= SimpleUPNP._();
  }

  late final Options _options;
  late final StaticOptions _staticOptions;
  final StreamController<UPnPEvent> _events = StreamController.broadcast();
  State _state = State.uninitialized;

  late final Discovery _discovery = Discovery(
    _events.sink,
    _staticOptions,
    SSDPDiscovery(
      _events.sink,
      _staticOptions,
    ),
  );

  late final ServiceControl _control = ServiceControl(
    _events.sink,
    _staticOptions,
  );

  SimpleUPNP._();

  Stream<UPnPEvent> get events => _events.stream;
  Stream<UPnPDevice> get discovered => _discovery.discovered;

  Future<InvocationResponse> invoke(
    UPnPDevice device,
    ServiceDocument serviceDocument,
    String actionName,
    Map<String, dynamic> args,
  ) {
    return _control.send(
      device.client.location!,
      serviceDocument,
      actionName,
      args,
    );
  }

  Future<void> start(Options options) async {
    if (_state != State.uninitialized) {
      throw InvalidStateError(_state, State.uninitialized);
    }

    _options = options;
    _staticOptions = await StaticOptions.create();

    await _discovery.start(_options);

    _state = State.ready;
  }

  Future<void> stop() async {
    await Future.wait([
      _events.close(),
      _discovery.stop(),
      _control.stop(),
    ]);
  }

  Future<void> search(String searchTarget) {
    _state = State.searching;

    _discovery.search(searchTarget);

    return Future.delayed(Duration(seconds: _options.maxDelay)).then((_) {
      _state = State.ready;
    });
  }
}

class InvalidStateError extends Error {
  final String message;
  InvalidStateError(State state, State expected)
      : message = 'Expected $expected, got $state';

  @override
  String toString() {
    return 'InvalidStateError: $message';
  }
}
