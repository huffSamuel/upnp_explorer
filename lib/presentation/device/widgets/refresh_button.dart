import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RefreshIconButton extends StatelessWidget {
  final Function()? onPressed;

  const RefreshIconButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)!.refresh,
      icon: Icon(Icons.refresh),
      onPressed: onPressed,
      color: Theme.of(context).appBarTheme.foregroundColor,
    );
  }
}
