import 'package:flutter/material.dart' hide Action;
import 'package:upnp_explorer/extension/build_context.dart';
import 'package:upnped/upnped.dart';

import '../../../discovery/presentation/widgets/item_list_card.dart';
import 'action_input_builder.dart';
import 'my_field.dart';

class ActionInputsCard extends StatefulWidget {
  final Action action;
  final ServiceStateTable serviceStateTable;

  const ActionInputsCard({
    super.key,
    required this.action,
    required this.serviceStateTable,
  });

  @override
  State<ActionInputsCard> createState() => ActionInputsCardState();
}

class ActionInputsCardState extends State<ActionInputsCard> {
  final _value = <String, String?>{};

  final _formKey = GlobalKey<FormState>();

  Map<String, String?>? validate() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      return _value;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    return Form(
      key: _formKey,
      child: ItemListCard(
        separatorBuilder: (_) => const SizedBox(height: 8),
        items: widget.action.inputs,
        title: Row(
          children: [
            Icon(Icons.settings_input_component,
                color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: 12),
            Text(
              i18n.inputParameters,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -.3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        itemBuilder: (c, i) {
          return MyField(
            label: Text(i.name.toUpperCase()),
            child: ActionInputBuilder(
              onSaved: (k, v) => _value[k] = v,
              argument: i,
              stateVariable: widget.serviceStateTable.stateVariables
                  .where((sv) => sv.name == i.relatedStateVariable)
                  .singleOrNull,
            ),
          );
        },
      ),
    );
  }
}
