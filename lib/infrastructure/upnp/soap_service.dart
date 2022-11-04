import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

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

  SoapService(this.userAgentBuilder);

  Future<ActionResponse> send(
    Uri uri,
    ActionInvocation action,
  ) async {
    final dto = ActionInvocationDto.fromDomain(action);

    final body = dto.body();

    final response = await http.post(
      uri,
      headers: {
        'HOST': '${uri.host}:${uri.port}',
        'CONTENT-LENGTH': body.length.toString(),
        'CONTENT-TYPE': 'text/xml; charset="utf-8"',
        'USER-AGENT': userAgentBuilder.build(version: '2.0'),
        'SOAPAction': dto.header(),
      },
      body: dto.body(),
    );

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
