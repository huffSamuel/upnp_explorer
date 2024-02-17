part of simple_upnp;

class InvocationResponse {
  final String actionName;
  final Map<String, String> arguments;

  InvocationResponse(
    this.actionName,
    this.arguments,
  );

  factory InvocationResponse.parse(String str) {
    final Map<String, String> arguments = {};
    final xml = XmlDocument.parse(str);
    final node = xml.rootElement
        .getElement('s:Body')!
        .children
        .firstWhere((el) => el is XmlElement) as XmlElement;

    if (node.localName == "Fault") {
      throw "Parse the fault with ActionFault";
    }

    node.children.whereType<XmlElement>().forEach(
          (x) => arguments[x.localName] = x.innerText,
        );

    return InvocationResponse(
      node.localName.replaceAll('Response', ''),
      arguments,
    );
  }
}
