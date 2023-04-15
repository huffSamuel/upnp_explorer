part of upnp;

class WakeOnLan {
  WakeOnLan() {}

  static bool supportedBy(http.Response response, XmlNode document) {
    final wakeSupportedNode =
        document.getElement('microsoft:magicPacketWakeSupported');

    if (wakeSupportedNode == null) {
      return false;
    }

    final supportedValue =
        (wakeSupportedNode.firstChild as XmlText).text.trim();

    return supportedValue == '1';
  }
}
