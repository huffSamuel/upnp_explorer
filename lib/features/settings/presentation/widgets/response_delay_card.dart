import 'package:flutter/material.dart';
import '../../../core/presentation/widgets/section_header.dart';
import 'setting_description.dart';

import '../../../../application/l10n/app_localizations.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/number_input.dart';
import '../../../control/presentation/widgets/my_field.dart';

class ResponseDelayCard extends StatelessWidget {
  final TextEditingController controller;

  const ResponseDelayCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return MyCard(
      child: Column(
        children: [
          SectionHeader(icon: Icon(Icons.timer), title: Text(i18n.maxResponseDelay)),
          const SizedBox(height: 16),
          MyField(
            label: Text(i18n.seconds),
            child: NumberInput(controller: controller),
          ),
          const SizedBox(height: 16),
          SettingDescription(
            child: Text(
              i18n.maxDelayDescription,
            ),
          ),
        ],
      ),
    );
  }
}
