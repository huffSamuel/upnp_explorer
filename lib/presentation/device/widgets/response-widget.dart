import 'package:flutter/material.dart';

import '../../../data/ssdp_response_message.dart';
import '../../../generated/l10n.dart';
import '../../core/widgets/raw-toggle-widget.dart';

class _FormattedResponseWidget extends StatelessWidget {
  final SSDPResponseMessage response;

  const _FormattedResponseWidget({Key key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    var formattedChildren = <Widget>[];
    response.parsed.forEach((key, value) {
      if (key.isEmpty) {
        return;
      }

      formattedChildren.addAll([
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Text(
            key,
            style: textTheme.headline6,
          ),
        ),
        Text(
          value.isEmpty ? i18n.na : value,
        ),
      ]);
    });

    return Column(
      children: formattedChildren,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

class ResponseWidget extends StatelessWidget {
  final SSDPResponseMessage response;

  const ResponseWidget({Key key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final raw = Text(response.raw);
    final formatted = _FormattedResponseWidget(response: response);

    return RawToggleWidget(
      raw: raw,
      formatted: formatted,
    );
  }
}
