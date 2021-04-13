import 'package:xml/xml.dart';

import '../data/ssdp_response_message.dart';

class Device {
  final String ipAddress;
  final SSDPResponseMessage response;
  final List<DeviceDocument> documents = [];
  String locationData;
  DeviceProperties properties;
  XmlDocument xml;

  Device(this.response) : this.ipAddress = response.ipAddress;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device) && other.response == this.response;

  @override
  int get hashCode => this.response.hashCode;
}

class DeviceDocument {
  final XmlDocument xmlDocument;
  final String name;

  DeviceDocument(this.xmlDocument, this.name);

  factory DeviceDocument.parse(String xml, String name, String baseUri) {
    final document = XmlDocument.parse(xml);

    try {
      final otherLinks = _findLinks(document.rootElement, baseUri);
      print(otherLinks);
    } catch (e) {
      print(e);
    }

    return DeviceDocument(XmlDocument.parse(xml), name);
  }

  static List<Uri> _findLinks(XmlNode element, String baseUri) {
    if (element is XmlText && element.text.trim().isNotEmpty) {
      final text = element.text.trim();

      if (text.endsWith('.xml')) {
        final uri = Uri.tryParse('$baseUri${element.text}');

        if (uri != null) {
          return [uri];
        }
      }

      return [];
    } else {
      var links = <Uri>[];

      element.children.forEach((c) => links.addAll(_findLinks(c, baseUri)));

      return links;
    }
  }
}

class DeviceProperties {
  String locationData;
  String friendlyName;
  String imageUrl;
  String manufacturer;
  String model;

  Uri imageUri() {
    var location = Uri.parse(locationData);

    if (locationData == null || imageUrl == null) {
      return null;
    }

    return Uri(
        scheme: location.scheme,
        host: location.host,
        port: location.port,
        pathSegments: ['setup', 'icon.png']);
  }
}
