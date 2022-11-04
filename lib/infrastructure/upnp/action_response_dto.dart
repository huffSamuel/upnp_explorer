import 'package:xml/xml.dart';

import '../../domain/upnp/action_argument.dart';
import '../../domain/upnp/action_response.dart';

class ActionResponseDto extends ActionResponse {
  ActionResponseDto(
    String actionName,
    List<ActionArgument> arguments,
  ) : super(
          actionName,
          arguments,
        );

  factory ActionResponseDto.parse(String str) {
    final arguments = <ActionArgument>[];
    final xml = XmlDocument.parse(str);
    final node =
        xml.rootElement.getElement('s:Body')!.children.first as XmlElement;

    for (final arg in node.children.whereType<XmlElement>()) {
      arguments.add(ActionArgument(arg.localName, arg.innerText));
    }

    return ActionResponseDto(
      node.localName.replaceAll('Response', ''),
      arguments,
    );
  }
}
