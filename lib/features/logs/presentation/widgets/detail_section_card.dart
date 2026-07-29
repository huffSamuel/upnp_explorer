import 'package:flutter/material.dart';
import 'package:upnp_explorer/features/core/presentation/widgets/my_card.dart';

class DetailSectionCard extends StatelessWidget {
  final Widget title;
  final Widget child;

  const DetailSectionCard(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 4),
        child,
      ],
    ));
  }
}
