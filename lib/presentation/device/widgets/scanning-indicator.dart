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
    return Semantics(
      label: S.of(context).scanningForDevices,
      child: AnimatedContainer(
        height: height,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 150),
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).canvasColor,
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
