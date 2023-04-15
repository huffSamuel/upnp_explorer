library upnp;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

part 'src/device/device.dart';
part 'src/device/client.dart';
part 'src/device/extensions/wake_on_lan.dart';
part 'src/search_request.dart';
part 'src/search_target.dart';
part 'src/discovery.dart';
part 'src/messages.dart';
part 'src/error/action_invocation_error.dart';
part 'src/control.dart';
part 'src/dial/dial.dart';

final StreamController<NetworkMessage> _messageController =
    StreamController.broadcast();
final StreamController<UPnPDevice> _deviceController =
    StreamController.broadcast();

Stream<UPnPDevice> get deviceEvents => _deviceController.stream;
Stream<NetworkMessage> get messageEvents => _messageController.stream;
