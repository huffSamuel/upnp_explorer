import 'package:xml/xml.dart';

class DeviceDocument {
  final XmlDocument xmlDocument;
  final String name;

  DeviceDocument(
    this.xmlDocument,
    this.name,
  );
}
