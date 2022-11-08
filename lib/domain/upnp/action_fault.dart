import 'package:xml/xml.dart';

class ActionFault {
  final String code;
  final String description;

  ActionFault(
    this.code,
    this.description,
  );

  factory ActionFault.parse(String str) {
    final xml = XmlDocument.parse(str);
    final node = xml.rootElement
        .getElement('s:Body')!
        .getElement('s:Fault')!
        .getElement('detail')!
        .getElement('UPnPError')!;

    final code = node.getElement('errorCode')!.innerText;
    final description = node.getElement('errorDescription')!.innerText;

    return ActionFault(code, description);
  }
}
