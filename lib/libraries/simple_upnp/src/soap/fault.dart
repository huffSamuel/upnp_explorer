part of simple_upnp;

class InvocationFault {
  final String code;
  final String description;

  InvocationFault(
    this.code,
    this.description,
  );

  factory InvocationFault.parse(String str) {
    final xml = XmlDocument.parse(str);
    final node = xml.rootElement
        .getElement('s:Body')!
        .getElement('s:Fault')!
        .getElement('detail')!
        .getElement('UPnPError')!;

    final code = node.getElement('errorCode')!.innerText;
    final description = node.getElement('errorDescription')!.innerText;

    return InvocationFault(code, description);
  }
}
