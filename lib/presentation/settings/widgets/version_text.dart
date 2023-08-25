import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

class VersionText extends StatelessWidget {
  final version$ = Stream.fromFuture(PackageInfo.fromPlatform()).startWith(
    PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: version$,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Text('');
        }

        return Text(
          AppLocalizations.of(context)!.version(snapshot.data!.version),
        );
      },
    );
  }
}
