library upnp;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

part 'src/device.dart';
part 'src/client.dart';
part 'src/search_request.dart';
part 'src/search_target.dart';
part 'src/discovery.dart';
part 'src/messages.dart';
part 'src/error/action_invocation_error.dart';
part 'src/control.dart';

final StreamController<NetworkMessage> _messageController =
    StreamController.broadcast();
final StreamController<UPnPDevice> _deviceController =
    StreamController.broadcast();

Stream<UPnPDevice> get deviceEvents => _deviceController.stream;
Stream<NetworkMessage> get messageEvents => _messageController.stream;
