import 'package:flutter/material.dart';

import '../../../../application/l10n/app_localizations.dart';
import '../../logic/service.dart';

class RefreshIconButton extends StatelessWidget {
  final DiscoveryStateService service;

  const RefreshIconButton({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: service.state,
      builder: (context, snapshot) {
        final canRefresh = snapshot.hasData && snapshot.data!.canRefresh;

        return IconButton(
          tooltip: AppLocalizations.of(context)!.refresh,
          icon: const Icon(Icons.refresh),
          onPressed: canRefresh ? service.search : null,
        );
      },
    );
  }
}
