import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:upnp_explorer/packages/upnp/upnp.dart';

class NetworkMessageDialog extends StatelessWidget {
  final NetworkMessage message;

  const NetworkMessageDialog({
    super.key,
    required this.message,
  });

  Widget _messageContent(TextStyle? style) {
    if (message is SearchRequest) {
      return Text(
        (message as SearchRequest).content,
        style: style,
      );
    }

    return Text(
      (message as NotifyResponse).content,
      style: style,
    );
  }

  Widget _pad(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;

    final codeTheme = theme.bodySmall;

    return AlertDialog(
      contentPadding: EdgeInsets.only(
        left: 24.0,
        right: 8.0,
      ),
      title: Text(message.messageType),
      actions: [
        TextButton(
          child: Text(i18n.copyJson),
          onPressed: () => _copyJson(context),
        ),
        TextButton(
          child: Text(i18n.close),
          onPressed: () => _close(context),
        ),
      ],
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message is NotifyResponse)
                _pad(
                  Text(
                    (message as NotifyResponse).uri.authority,
                    style: codeTheme,
                  ),
                ),
              _pad(Text(
                DateFormat('H:m:s.SSS').format(message.time),
                style: codeTheme,
              )),
              _messageContent(codeTheme),
            ],
          ),
        ),
      ),
    );
  }

  void _copyJson(BuildContext context) {
    final obj = {
      'type': message.messageType,
      'direction': message.direction.name,
      'time': message.time.toIso8601String(),
      'content': (message as dynamic).content,
    };

    Clipboard.setData(
      ClipboardData(
        text: jsonEncode(obj),
      ),
    ).then(
      (_) => _close(context),
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class HttpNetworkMessageDialog extends StatelessWidget {
  final HttpMessage message;

  const HttpNetworkMessageDialog({
    super.key,
    required this.message,
  });

  Widget _pad(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;

    final codeTheme = theme.bodySmall;

    return AlertDialog(
      title: Text(message.messageType),
      contentPadding: EdgeInsets.only(
        left: 24.0,
        right: 8.0,
      ),
      actions: [
        TextButton(
          child: Text(i18n.copyJson),
          onPressed: () => _copyJson(context),
        ),
        TextButton(
          child: Text(i18n.close),
          onPressed: () => _close(context),
        ),
      ],
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(i18n.request, style: theme.labelLarge),
              _pad(Text('${message.request.method} ${message.request.url}',
                  style: codeTheme)),
              _pad(Text('${_mapToString(message.request.headers)}',
                  style: codeTheme)),
              if (message.request.body.isNotEmpty == true)
                _pad(Text(message.request.body, style: codeTheme)),
              Divider(),
              Text(i18n.response, style: theme.labelLarge),
              _pad(
                Text(
                  '${message.response.statusCode} - ${message.response.reasonPhrase}',
                  style: theme.bodySmall,
                ),
              ),
              _pad(
                Text(
                  '${_mapToString(message.response.headers)}',
                  style: theme.bodySmall,
                ),
              ),
              _pad(
                Text(
                  '${message.response.body}',
                  style: theme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyJson(BuildContext context) {
    final obj = {
      'request': {
        'headers': message.request.headers,
        'url': message.request.url.toString(),
        'body': message.request.body,
      },
      'response': {
        'headers': message.response.headers,
        'status': message.response.statusCode,
        'reasonPhrase': message.response.reasonPhrase,
        'body': message.response.body
      }
    };

    Clipboard.setData(
      ClipboardData(
        text: jsonEncode(obj),
      ),
    ).then(
      (_) => _close(context),
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  String _mapToString(Map<String, String> headers) {
    return headers.entries
        .map<String>((e) => '${e.key}: ${e.value}')
        .join('\n');
  }
}
