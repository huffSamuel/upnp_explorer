import 'package:flutter/widgets.dart';

class LeadingIconBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const LeadingIconBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: builder(context),
    );
  }
}
