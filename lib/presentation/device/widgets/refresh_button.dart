import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';

class RefreshIconButton extends StatelessWidget {
  final Function()? onPressed;

  const RefreshIconButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).refresh,
      icon: Icon(Icons.refresh),
      onPressed: onPressed,
      color: Theme.of(context).appBarTheme.foregroundColor,
    );
  }
}
