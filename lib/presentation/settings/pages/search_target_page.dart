import 'package:flutter/material.dart';
import 'package:upnp_explorer/infrastructure/upnp/search_target.dart';

import '../../../application/l10n/generated/l10n.dart';
import '../../../application/settings/options.dart';

class SearchTargetPage extends StatefulWidget {
  @override
  State<SearchTargetPage> createState() => _SearchTargetPageState();
}

class _SearchTargetPageState extends State<SearchTargetPage> {
  late String _searchTarget;

  @override
  void didChangeDependencies() {
    _searchTarget = Options.of(context).protocolOptions.searchTarget;
    super.didChangeDependencies();
  }

  _setTarget(String? target) {
    if (target == null) {
      return;
    }

    setState(() => {_searchTarget = target});
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
                protocolOptions: options.protocolOptions
                    .copyWith(searchTarget: _searchTarget)));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Target'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text('Request that only specific types of UPnP devices respond to the discovery request.'),
            ),
            const Divider(thickness: 1.5),
            RadioListTile(
              value: SearchTarget.rootDevice().toString(),
              groupValue: _searchTarget,
              title: Text('Root Device'),
              subtitle: Text('Search for root devices only.'),
              onChanged: (String? target) => _setTarget(target),
              enableFeedback: true,
            ),
            RadioListTile(
              value: SearchTarget.all().toString(),
              groupValue: _searchTarget,
              title: Text('All'),
              subtitle: Text('Search for all devices and services.'),
              onChanged: (String? target) => _setTarget(target),
              enableFeedback: true,
            ),
          ],
        ),
      ),
    );
  }
}
