import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/settings.dart';
import '../../../core/widgets/number_ticker.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings_category_page.dart';

class MaximumResponseDelayPage extends StatefulWidget {
  const MaximumResponseDelayPage();

  @override
  State<MaximumResponseDelayPage> createState() =>
      _MaximumResponseDelayPageState();
}

class _MaximumResponseDelayPageState extends State<MaximumResponseDelayPage> {
  late int _delay;
  late bool _advanced;

  @override
  void didChangeDependencies() {
    final options = Settings.of(context).protocolOptions;
    _delay = options.maxDelay;
    _advanced = options.advanced;
    super.didChangeDependencies();
  }

  void _setDelay(int delay) {
    setState(() {
      _delay = delay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final options = Settings.of(context);
    final advanced = options.protocolOptions.advanced;

    return PopScope(
      onPopInvokedWithResult: (_, __) {
        Settings.update(
          context,
          options.copyWith(
            protocolOptions: options.protocolOptions.copyWith(
              maxDelay: _delay,
              advanced: _advanced,
            ),
          ),
        );
      },
      child: SettingsCategoryPage(
        category: i18n.maxResponseDelay,
        children: [
          if (advanced)
            NumberTickerListTile(
              minValue: 1,
              title: Text(''),
              onChanged: _setDelay,
              value: _delay,
            ),
          if (!advanced)
            Slider(
              divisions: _advanced ? 19 : 4,
              value: _delay.toDouble(),
              onChanged: (v) => _setDelay(v.toInt()),
              label: i18n.responseDelay(_delay),
              min: 1,
              max: _advanced ? 20 : 5,
            ),
          AboutTile(
            child: Text(i18n.maxDelayDescription),
          ),
        ],
      ),
    );
  }
}
