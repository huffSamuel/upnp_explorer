import 'package:flutter/material.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/settings/options.dart';
import '../../core/widgets/number_ticker.dart';

class MulticastHopsPage extends StatefulWidget {
  @override
  _MulticastHopsPageState createState() => _MulticastHopsPageState();
}

class _MulticastHopsPageState extends State<MulticastHopsPage> {
  late int _hops;

  @override
  void didChangeDependencies() {
    _hops = Options.of(context).protocolOptions.hops;
    super.didChangeDependencies();
  }

  _setHops(int hops) {
    setState(() {
      _hops = hops;
    });
  }

  @override
  Widget build(BuildContext context) {
    final options = Options.of(context);
    final i18n = S.of(context);

    return WillPopScope(
      onWillPop: () {
        Options.update(
          context,
          options.copyWith(
            protocolOptions: options.protocolOptions.copyWith(
              hops: _hops,
            ),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.multicastHops),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
              child: Text(i18n.multicastHopsDescription),
            ),
            const Divider(thickness: 1.5,),
            NumberTickerListTile(
              title: Text(i18n.multicastHops),
              value: _hops,
              minValue: 1,
              onChanged: _setHops,
            ),
          ],
        ),
      ),
    );
  }
}
