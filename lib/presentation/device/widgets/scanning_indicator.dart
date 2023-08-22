import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ScanningIndicator extends StatelessWidget {
  final double height;

  const ScanningIndicator({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration: const Duration(milliseconds: 175),
      curve: Curves.easeIn,
      child: Semantics(
        label: AppLocalizations.of(context)!.scanningForDevices,
        child: AnimatedContainer(
          height: height,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 150),
          child: const LinearProgressIndicator(),
        ),
      ),
    );
  }
}
