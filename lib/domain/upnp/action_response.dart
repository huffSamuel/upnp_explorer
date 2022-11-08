import 'package:xml/xml.dart';

import 'action_argument.dart';

class ActionResponse {
  final String actionName;
  final List<ActionArgument> arguments;

  ActionResponse(
    this.actionName,
    this.arguments,
  );

  factory ActionResponse.parse(String str) {
    final arguments = <ActionArgument>[];
    final xml = XmlDocument.parse(str);
    final node =
        xml.rootElement.getElement('s:Body')!.children.first as XmlElement;

    for (final arg in node.children.whereType<XmlElement>()) {
      arguments.add(ActionArgument(arg.localName, arg.innerText));
    }

    return ActionResponse(
      node.localName.replaceAll('Response', ''),
      arguments,
    );
  }
}
