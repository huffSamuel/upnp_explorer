import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionText extends StatefulWidget {
  @override
  State<VersionText> createState() => _VersionTextState();
}

class _VersionTextState extends State<VersionText> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then(
      (info) => setState(
        () {
          _version = AppLocalizations.of(context)!.version(info.version);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(_version);
  }
}
