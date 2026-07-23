import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import '../../../core/dark.dart';
import '../../../syntax_highlighting/highlighter.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/l10n/app_localizations.dart';
import '../../../core/light.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../../control/presentation/widgets/my_field.dart';

class LogPage extends StatelessWidget {
  final NetworkEvent event;
  final _controller = CodeEditorController(
    lightHighlighter: XmlHighlighter.lightHighlighter,
    darkHighlighter: XmlHighlighter.darkHighlighter,
  );

  LogPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary),
            onPressed: Navigator.of(context).pop,
          ),
          title: PageTitle(child: Text('Details'))),
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Scrollbar(
            child: ListView(children: [
          MyCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                            label: Text('METHOD'),
                            style: TextStyle(fontSize: 14)),
                        Text(event.type.toUpperCase(),
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    if (event is HttpEvent)
                      StatusChip(
                        statusCode: (event as HttpEvent).response.statusCode,
                        reasonPhrase:
                            (event as HttpEvent).response.reasonPhrase,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Label(label: Text('Timestamp'), style: TextStyle(fontSize: 14)),
                Text(
                  DateFormat('HH:mm:ss.SSS').format(event.time),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                      letterSpacing: .5),
                ),
              ],
            ),
          ),
          // TODO: Add a card to show what device this was from/to
          // This will require a repository/service to get the device information
          if (event is HttpEvent || event is MSearchEvent)
            MyCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.subject_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Request Headers',
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -.3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                HeaderMap(
                  headers: event is HttpEvent
                      ? (event as HttpEvent).request.headers
                      : parseHeaders((event as MSearchEvent).content),
                ),
              ],
            )),
          if (event is HttpEvent &&
              (event as HttpEvent).request.body.isNotEmpty)
            MyCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.code_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Payload',
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -.3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(12),
                    child: Text((event as HttpEvent).request.body))
              ],
            )),
          if (event is HttpEvent || event is NotifyEvent)
            MyCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.subject_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Response Headers',
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -.3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                HeaderMap(
                  headers: event is HttpEvent
                      ? (event as HttpEvent).response.headers
                      : parseHeaders((event as NotifyEvent).content),
                )
              ],
            )),
          if (event is HttpEvent &&
              (event as HttpEvent).responseBody?.isNotEmpty == true)
            MyCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.code_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Response Body',
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -.3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text.rich(XmlHighlighter.forTheme(theme).highlight((event as HttpEvent).responseBody ?? '')),
                // Container(
                //     padding: const EdgeInsets.all(12),
                //     decoration: BoxDecoration(
                //       color: ElevationOverlay.applySurfaceTint(
                //         colorScheme.surface,
                //         colorScheme.secondary,
                //         1,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Text((event as HttpEvent).responseBody ?? ''))
              ],
            ))
        ])),
      ),
    );
  }
}

class HeaderMap extends StatelessWidget {
  final Map<String, String> headers;

  const HeaderMap({super.key, required this.headers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...headers.entries.map(
          (e) => RichText(
            text: TextSpan(
                text: '${e.key}: ',
                style: TextStyle(color: Colors.blueGrey),
                children: [
                  TextSpan(
                    text: e.value,
                    style: TextStyle(
                        color: int.tryParse(e.value) == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.red),
                  ),
                ]),
          ),
        )
      ],
    );
  }
}

class StatusChip extends StatelessWidget {
  final int statusCode;
  final String? reasonPhrase;

  const StatusChip({super.key, required this.statusCode, this.reasonPhrase});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extension = theme.extension<MyCustomColors>()!;

    Color? background;
    Color? foreground;

    if (statusCode >= 200 && statusCode <= 299) {
      background = extension.brandSuccess;
      foreground = extension.onSuccess;
    } else if (statusCode >= 400 && statusCode <= 599) {
      background = theme.colorScheme.errorContainer;
      foreground = theme.colorScheme.error;
    }

    return Chip(
      color: WidgetStatePropertyAll(background),
      shape: StadiumBorder(
          side: BorderSide(color: background ?? const Color(0xFF000000))),
      label: Row(
        children: [
          if (statusCode >= 200 && statusCode <= 299)
            Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.check_circle_outline,
                    color: foreground, size: 16)),
          Text('$statusCode ${reasonPhrase ?? 'Unknown'}'),
        ],
      ),
      labelStyle: TextStyle(color: foreground),
    );
  }
}

Map<String, String> parseHeaders(String content) {
  final m = <String, String>{};

  final f = content.split('\r\n');

  for (var i = 1; i < f.length; ++i) {
    final h = f[i];
    final idx = h.indexOf(':');

    if (idx < 0) {
      continue;
    }

    m[h.substring(0, idx).trim()] = h.substring(idx + 1).trim();
  }

  return m;
}
