import 'package:flutter/material.dart';
import '../../../application/l10n/app_localizations.dart';

class ScanningIndicator extends StatelessWidget {
  final double height;

  const ScanningIndicator({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      firstChild: Semantics(
        label: AppLocalizations.of(context)!.scanningForDevices,
        child: LinearProgressIndicator(),
      ),
      secondChild: Container(
        height: 0,
      ),
      crossFadeState:
          height > 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
