import 'package:xml/xml.dart';

import '../../domain/upnp/action_fault.dart';

class ActionFaultDto extends ActionFault {
  ActionFaultDto(
    String code,
    String description,
  ) : super(
          code,
          description,
        );

  factory ActionFaultDto.parse(String str) {
    final xml = XmlDocument.parse(str);
    final node = xml.rootElement
        .getElement('s:Body')!
        .getElement('s:Fault')!
        .getElement('detail')!
        .getElement('UPnPError')!;

    final code = node.getElement('errorCode')!.innerText;
    final description = node.getElement('errorDescription')!.innerText;

    return ActionFaultDto(code, description);
  }
}
