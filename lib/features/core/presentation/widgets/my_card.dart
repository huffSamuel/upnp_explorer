import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final Color? highlight;
  final VoidCallback? onTap;
  final Color? color;

  const MyCard({
    super.key,
    this.child,
    this.padding,
    this.highlight,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget? body = highlight != null
        ? IntrinsicHeight(
            child: Row(
              children: [
                if (highlight != null)
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                        color: highlight!,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )),
                  ),
                if (child != null)
                  Expanded(
                      child: Padding(
                    padding: padding ??
                        const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16),
                    child: child!,
                  )),
              ],
            ),
          )
        : Padding(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: child,
          );
  
    Widget card = Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerLow,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 24,
            color: Color.fromRGBO(25, 28, 29, 0.04),
          ),
        ],
        borderRadius: highlight != null ? BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12)) :
         BorderRadius.circular(12),
      ),
      child: body,
    );

    return GestureDetector(child: card, onTap: onTap);
  }
}
