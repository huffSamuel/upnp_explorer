import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:upnp_explorer/application/network_logs/traffic_repository.dart';

import '../../domain/network_logs/network_logs_repository_type.dart';
import '../../domain/network_logs/traffic.dart';
import '../../domain/upnp/action_command.dart';
import '../../domain/upnp/action_response.dart';
import '../../domain/upnp/error.dart';
import 'action_fault_dto.dart';
import 'action_invocation_dto.dart';
import 'action_response_dto.dart';
import 'search_request_builder.dart';

@singleton
class SoapService {
  final UserAgentBuilder userAgentBuilder;
  final NetworkLogsRepository traffic;

  SoapService(
    this.userAgentBuilder,
    this.traffic,
  );

  Future<ActionResponse> send(
    Uri uri,
    ActionInvocation action,
  ) async {
    final dto = ActionInvocationDto.fromDomain(action);

    final body = dto.body();
    final headers = {
      'HOST': '${uri.host}:${uri.port}',
      'CONTENT-LENGTH': body.length.toString(),
      'CONTENT-TYPE': 'text/xml; charset="utf-8"',
      'USER-AGENT': userAgentBuilder.build(version: '2.0'),
      'SOAPAction': dto.header(),
    };

    final request = Request('POST', uri)
      ..body = body
      ..headers.addAll(headers);

    traffic.add(Traffic<Request>(
      request,
      TrafficProtocol.soap,
      TrafficDirection.outgoing,
    ));

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    traffic.add(Traffic<Response>(
      response,
      TrafficProtocol.soap,
      TrafficDirection.incoming,
    ));

    try {
      return ActionResponseDto.parse(response.body);
    } catch (err) {
      final error = ActionFaultDto.parse(response.body);

      throw ActionInvocationError(
        error.description,
        error.code,
      );
    }
  }
}
