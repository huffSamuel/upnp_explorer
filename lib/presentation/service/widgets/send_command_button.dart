import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendCommandButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;

  const SendCommandButton({
    Key? key,
    required this.onPressed,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return OutlinedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed?.call();
      },
      child: Semantics(
        label: i18n.sendCommand(name),
        child: Icon(
          Icons.arrow_forward,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(24),
      ),
    );
  }
}
