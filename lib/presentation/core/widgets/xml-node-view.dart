import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class XmlNodeView extends StatelessWidget {
  final XmlElement element;
  final bool displaySelf;
  final int depth;

  const XmlNodeView({
    Key key,
    @required this.element,
    this.displaySelf = true,
    this.depth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;

    return Padding(
      padding: EdgeInsets.only(left: 4.0 * depth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (displaySelf && element.name.local.isNotEmpty)
            Text(
              element.name.local,
              style: titleStyle,
              softWrap: true,
            ),
          ...element.children.map(
            (e) {
              if (e is XmlElement) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: XmlNodeView(
                    element: e,
                    depth: depth + 1,
                  ),
                );
              } else if (e is XmlText && e.text.trim().isNotEmpty) {
                return Text(
                  e.text.trim(),
                  softWrap: true,
                );
              }
              return Container(height: 0, width: 0);
            },
          ).where((x) => x != null),
        ],
      ),
    );
  }
}
