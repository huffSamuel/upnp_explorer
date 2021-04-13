import 'package:flutter/material.dart';

class DeviceExpansionTile extends StatelessWidget {
  final bool initiallyExpanded;
  final Widget title;
  final Widget subtitle;
  final Widget child;

  const DeviceExpansionTile({
    Key key,
    this.initiallyExpanded = false,
    @required this.title,
    @required this.child,
    this.subtitle,
  })  : assert(child != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      childrenPadding: const EdgeInsets.only(left: 16.0),
      title: title,
      subtitle: subtitle,
      children: [child],
    );
  }
}
