import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/service.dart';

class RefreshIconButton extends StatelessWidget {
  final DiscoveryStateService service;

  const RefreshIconButton({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: service.state,
      builder: (context, snapshot) {
        final canRefresh = snapshot.hasData &&
            !snapshot.data!.scanning &&
            !snapshot.data!.loading &&
            snapshot.data!.wifi;

        return IconButton(
          tooltip: AppLocalizations.of(context)!.refresh,
          icon: const Icon(Icons.refresh),
          onPressed: canRefresh ? service.search : null,
        );
      },
    );
  }
}
