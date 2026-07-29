import 'package:flutter/material.dart';
import 'package:upnp_explorer/application/l10n/app_localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations i18n() => AppLocalizations.of(this)!;
}