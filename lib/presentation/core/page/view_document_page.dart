import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class XmlDocumentPage extends StatelessWidget {
  final XmlDocument xml;
  final ScrollController controller;

  XmlDocumentPage({
    Key? key,
    required this.xml,
  })  : controller = ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('XML'),
      ),
      body: Scrollbar(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              xml.toXmlString(
                pretty: true,
                indentAttribute: (x) => true,
                spaceBeforeSelfClose: (x) => true,
                sortAttributes: (a, b) => a.name.toString().compareTo(b.name.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
