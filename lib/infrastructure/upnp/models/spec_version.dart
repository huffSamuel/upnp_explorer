import 'package:xml/xml.dart';

class SpecVersion {
  final int major;
  final int minor;

  SpecVersion({
    required this.major,
    required this.minor,
  });

  static fromXml(XmlNode node) {
    return SpecVersion(
      major: int.parse(node.getElement('major')!.text),
      minor: int.parse(node.getElement('minor')!.text),
    );
  }
}
