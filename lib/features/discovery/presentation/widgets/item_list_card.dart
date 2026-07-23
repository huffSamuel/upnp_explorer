import 'package:flutter/material.dart';

import '../../../core/presentation/widgets/my_card.dart';

class ItemListCard<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(BuildContext)? separatorBuilder;
  final Widget title;

  const ItemListCard({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.title,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: MyCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            title,
            const SizedBox(height: 12),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, i) => Material(
                color: Colors.transparent,
                child: itemBuilder(c, items[i])),
              separatorBuilder: (c, __) => separatorBuilder == null
                  ? Divider(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh)
                  : separatorBuilder!(c),
              itemCount: items.length,
            )
          ],
        ),
      ),
    );
  }
}
