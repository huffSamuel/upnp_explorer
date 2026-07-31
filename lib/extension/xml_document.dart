import 'package:xml/xml.dart';

extension XmlDocumentTry on XmlDocument {
  static XmlDocument? parse(String? string) {
    if (string == null) {
      return null;
    }

    try {
      return XmlDocument.parse(string);
    } catch (_) {
      return null;
    }
  }
}
