import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../application/settings/options.dart';
import '../../../core/widgets/number_ticker.dart';
import '../../widgets/settings/about_tile.dart';
import '../../widgets/settings_category_page.dart';
import '../../widgets/settings_category_tile.dart';

class MulticastHopsPage extends StatefulWidget {
  const MulticastHopsPage();

  @override
  State<MulticastHopsPage> createState() => _MulticastHopsPageState();
}

class _MulticastHopsPageState extends State<MulticastHopsPage> {
  late int _hops;
  @override
  void didChangeDependencies() {
    _hops = Settings.of(context).protocolOptions.hops;
    super.didChangeDependencies();
  }

  _setHops(int hops) {
    setState(() {
      _hops = hops;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final options = Settings.of(context);

    return WillPopScope(
      onWillPop: () {
        Settings.update(
          context,
          options.copyWith(
            protocolOptions: options.protocolOptions.copyWith(hops: _hops),
          ),
        );
        return Future.value(true);
      },
      child: SettingsCategoryPage(
        category: i18n.multicastHops,
        children: [
          NumberTickerListTile(
            title: SizedBox(height: 8.0),
            value: _hops,
            minValue: 1,
            onChanged: _setHops,
          ),
          SettingsDivider(),
          AboutTile(
            child: Text(i18n.multicastHopsDescription),
          ),
        ],
      ),
    );
  }
}
