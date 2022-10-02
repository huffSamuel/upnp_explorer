import 'package:flutter/material.dart';

import '../../../application/l10n/generated/l10n.dart';

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
      duration: Duration(milliseconds: 175),
      curve: Curves.easeIn,
      child: Semantics(
        label: S.of(context).scanningForDevices,
        child: AnimatedContainer(
          height: height,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 150),
          child: LinearProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
