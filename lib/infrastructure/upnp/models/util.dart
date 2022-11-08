import 'package:xml/xml.dart';

nodeMapper<T>(
  XmlNode? xml,
  String elementType,
  T Function(XmlNode) buildFn,
) =>
    xml?.findAllElements(elementType).map<T>(buildFn).toList() ?? [];
