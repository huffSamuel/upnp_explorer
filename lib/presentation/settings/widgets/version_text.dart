import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../application/version_service.dart';

class VersionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.fromFuture(GetIt.I.get<VersionService>().getVersion()),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Text('');
        }

        return Text(
          AppLocalizations.of(context)!.version(snapshot.data!),
        );
      },
    );
  }
}
