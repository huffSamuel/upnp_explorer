import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../application/settings/options.dart';
import '../../core/widgets/number_ticker.dart';

const _kMaxDefaultDelay = 5;
const _kMinDelay = 1;

class MaxResponseDelayPage extends StatefulWidget {
  @override
  _MaxResponseDelayPageState createState() => _MaxResponseDelayPageState();
}

class _MaxResponseDelayPageState extends State<MaxResponseDelayPage> {
  late int _delay;
  late bool _advanced;

  @override
  void didChangeDependencies() {
    final options = Options.of(context).protocolOptions;
    _delay = options.maxDelay;
    _advanced = options.advanced;
    super.didChangeDependencies();
  }

  setAdvanced(bool advanced) {
    setState(() {
      _advanced = advanced;

      if (!_advanced) {
        _delay = _delay.clamp(1, 5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final options = Options.of(context);

    return WillPopScope(
      onWillPop: () {
        Options.update(
          context,
          options.copyWith(
            protocolOptions: options.protocolOptions.copyWith(
              maxDelay: _delay,
              advanced: _advanced,
            ),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.maxResponseDelay),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
              child: Text(i18n.maxDelayDescription),
            ),
            const Divider(thickness: 1.5),
            NumberTickerListTile(
              title: Text(i18n.maxResponseDelay),
              value: _delay,
              minValue: _kMinDelay,
              maxValue: _advanced ? null : _kMaxDefaultDelay,
              onChanged: (delay) => setState(() => _delay = delay),
            ),
            const Divider(
              thickness: 1.5,
            ),
            SwitchListTile(
              value: _advanced,
              onChanged: setAdvanced,
              title: Text(i18n.advancedMode),
              subtitle: Text(i18n.advancedModeDescription),
            ),
          ],
        ),
      ),
    );
  }
}
