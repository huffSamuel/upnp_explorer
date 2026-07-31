import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:upnped/upnped.dart';

import '../../../../extension/build_context.dart';
import '../../../discovery/presentation/widgets/item_list_card.dart';
import 'action_result.dart';
import 'my_field.dart';

class ActionOutputsCard extends StatelessWidget {
  final Action action;
  final ActionResult result;

  const ActionOutputsCard({
    super.key,
    required this.action,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return ItemListCard(
      separatorBuilder: (_) => const SizedBox(height: 8),
      items: action.outputs,
      itemBuilder: (c, i) =>
          OutputText(name: i.name, value: result.results?[i.name]),
      title: Row(
        children: [
          Icon(Icons.output, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            i18n.response,
            style: TextTheme.of(context).bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -.3,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}

class OutputText extends StatelessWidget {
  final String name;
  final String? value;

  const OutputText({
    super.key,
    required this.name,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final child = LayoutBuilder(
      builder: (context, constraints) {
        final actions = <Widget>[
          if (value != null)
            IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 16,
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value!));
              },
            ),
        ];

        final span = TextSpan(
          text: value,
          style: Theme.of(context).textTheme.bodyMedium,
        );
        final tp = TextPainter(
          text: span,
          maxLines: 2,
          textDirection: TextDirection.ltr,
        );
        tp.layout(maxWidth: constraints.maxWidth);

        actions.insert(
          0,
          Opacity(
            opacity: tp.didExceedMaxLines ? 1 : 0,
            child: IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 16,
              icon: Icon(Icons.open_in_full),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (c) => SimpleDialog(
                    insetPadding: const EdgeInsets.all(8),
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    title: FittedBox(
                      alignment: Alignment.topLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        style: TextTheme.of(context).bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -.3,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    backgroundColor: Theme.of(c).cardColor,
                    children: [
                      OutputTextField(
                        value: value,
                        maxLines: null,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );

        return OutputTextField(
          value: value,
          trailing: actions,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
      },
    );

    return MyField(
      label: Text(name.toUpperCase()),
      child: child,
    );
  }
}

class OutputTextField extends StatelessWidget {
  final String? value;
  final List<Widget>? trailing;
  final int? maxLines;
  final TextOverflow? overflow;

  const OutputTextField({
    super.key,
    this.value,
    this.trailing,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.fromLTRB(18, 12, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(fontSize: 16),
              child: Text(
                value ?? '--',
                maxLines: maxLines,
                overflow: overflow,
              ),
            ),
          ),
          if (trailing != null) Row(children: trailing!),
        ],
      ),
    );
  }
}
