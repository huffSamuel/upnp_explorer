import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../application/settings/protocol_settings.dart';
import '../../../../application/settings/settings.dart';
import '../../../../extension/build_context.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../widgets/auto_refresh_card.dart';
import '../widgets/multicast_hops_card.dart';
import '../widgets/protocol_changes_hint_card.dart';
import '../widgets/reset_defaults_button.dart';
import '../widgets/response_delay_card.dart';

// TODO: Implement custom form logic
// FormFields onSave update a key-value map with the string value
// And a serializer converts it to an actual object.
class ProtocolSettingsPage extends StatefulWidget {
  const ProtocolSettingsPage({super.key});

  @override
  State<ProtocolSettingsPage> createState() => _ProtocolSettingsPageState();
}

class _ProtocolSettingsPageState extends State<ProtocolSettingsPage> {
  final _form = GlobalKey<FormState>();
  final _delayController = TextEditingController();
  final _hopsController = TextEditingController();
  bool _autoRefresh = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final settings = Settings.of(context);

      _autoRefresh = settings.autoRefresh;
      _delayController.text = settings.protocolOptions.maxDelay.toString();
      _hopsController.text = settings.protocolOptions.hops.toString();

      setState(() {
        _autoRefresh = settings.autoRefresh;
      });
    });
  }

  @override
  void dispose() {
    _delayController.dispose();
    _hopsController.dispose();

    super.dispose();
  }

  void _reset() {
    final d = ProtocolSettings();

    _delayController.text = d.maxDelay.toString();
    _hopsController.text = d.hops.toString();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(child: Text(i18n.settings)),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: _form,
        onPopInvokedWithResult: (didPop, result) {
          if (_form.currentState?.validate() == true) {
            _form.currentState!.save();

            final settings = Settings.of(context);

            Settings.update(
              context,
              settings.copyWith(
                autoRefresh: _autoRefresh,
                protocolOptions: settings.protocolOptions.copyWith(
                  hops: int.parse(_hopsController.text),
                  maxDelay: int.parse(_delayController.text),
                ),
              ),
            );
          }
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8),
              child: Text(
                i18n.discoverySettings,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -.3,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 8, top: 6, bottom: 16),
              child: Text(
                i18n.discoverySettingsDescription,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                      letterSpacing: -.3,
                    ),
              ),
            ),
            ResponseDelayCard(
              controller: _delayController,
            ),
            MulticastHopsCard(
              controller: _hopsController,
            ),
            AutoRefreshCard(
                value: _autoRefresh,
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _autoRefresh = v;
                    });
                  }
                }),
            ChangesHintCard(),
            const SizedBox(height: 16),
            ResetToDefaultsCard(
              onPressed: _reset,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
