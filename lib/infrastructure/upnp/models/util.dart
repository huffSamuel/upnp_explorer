import 'package:xml/xml.dart';

xmlNodeBuilder<T>(
        XmlNode? xml, String elementType, T Function(XmlNode) buildFn) =>
    xml?.findAllElements(elementType).map<T>(buildFn).toList() ?? [];
