import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import '../../application/network_logs/network_logs_repository.dart';

import '../../domain/network_logs/direction.dart';
import '../../domain/network_logs/network_logs_repository_type.dart';
import '../../domain/network_logs/protocol.dart';
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
      ...dto.headers,
      'HOST': '${uri.host}:${uri.port}',
      'USER-AGENT': userAgentBuilder.build(version: '2.0'),
    };

    final request = Request('POST', uri)
      ..body = body
      ..headers.addAll(headers);

    traffic.add(Traffic(
      message: requestToString(request),
      protocol: Protocol.soap,
      direction: Direction.outgoing,
      origin: thisDevice,
    ));

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    traffic.add(Traffic(
      message: responseToString(response),
      protocol: Protocol.soap,
      direction: Direction.incoming,
      origin: response.request!.url.authority,
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
