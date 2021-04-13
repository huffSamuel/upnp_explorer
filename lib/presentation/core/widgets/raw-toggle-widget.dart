import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class RawToggleWidget extends StatefulWidget {
  final Widget raw;
  final Widget formatted;

  const RawToggleWidget({Key key, this.raw, this.formatted}) : super(key: key);

  @override
  _RawToggleWidgetState createState() => _RawToggleWidgetState();
}

class _RawToggleWidgetState extends State<RawToggleWidget> {
  bool _raw = false;

  void _toggle() {
    setState(() {
      _raw = !_raw;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);

    final buttonText = _raw ? i18n.viewFormatted : i18n.viewRaw;

    final button = TextButton(
      child: Text(buttonText),
      onPressed: _toggle,
    );

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: widget.formatted,
            secondChild: widget.raw,
            crossFadeState:
                _raw ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 150),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: button,
          ),
        ],
      ),
    );
  }
}
