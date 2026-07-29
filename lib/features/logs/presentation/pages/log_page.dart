import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../extension/build_context.dart';
import '../../../control/presentation/widgets/my_field.dart';
import '../../../core/custom_colors.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../../core/presentation/widgets/section_header.dart';
import '../widgets/detail_section_card.dart';
import '../widgets/source_code.dart';

class LogPage extends StatelessWidget {
  final NetworkEvent event;
  const LogPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: PageTitle(
          child: Text(i18n.details),
        ),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
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
                              label: Text(i18n.method.toUpperCase()),
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
                  Label(
                      label: Text(i18n.timestamp),
                      style: TextStyle(fontSize: 14)),
                  Text(
                    i18n.timestampValue(event.time),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theme.hintColor,
                      fontSize: 16,
                      letterSpacing: .5,
                    ),
                  ),
                ],
              ),
            ),
            // TODO: Add a card to show what device this was from/to
            // This will require a repository/service to get the device information
            if (event is HttpEvent || event is MSearchEvent)
              DetailSectionCard(
                title: SectionHeader(
                    icon: Icon(Icons.subject_outlined),
                    title: Text(i18n.requestHeaders)),
                child: HeaderMap(
                  headers: event is HttpEvent
                      ? (event as HttpEvent).request.headers
                      : parseHeaders((event as MSearchEvent).content),
                ),
              ),

            if (event is HttpEvent &&
                (event as HttpEvent).request.body.isNotEmpty)
              DetailSectionCard(
                title: SectionHeader(
                  icon: Icon(Icons.code_outlined),
                  title: Text(i18n.payload),
                ),
                child: SourceCode(text: (event as HttpEvent).request.body),
              ),

            if (event is HttpEvent || event is NotifyEvent)
              DetailSectionCard(
                title: SectionHeader(
                    icon: Icon(Icons.subject_outlined),
                    title: Text(i18n.responseHeaders)),
                child: HeaderMap(
                  headers: event is HttpEvent
                      ? (event as HttpEvent).response.headers
                      : parseHeaders((event as NotifyEvent).content),
                ),
              ),

            if (event is HttpEvent &&
                (event as HttpEvent).responseBody?.isNotEmpty == true)
              DetailSectionCard(
                title: SectionHeader(
                    icon: Icon(Icons.code_outlined),
                    title: Text(i18n.responseBody)),
                child:
                    SourceCode(text: (event as HttpEvent).responseBody ?? ''),
              ),
          ],
        ),
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
    final i18n = context.i18n();
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
          Text(i18n.codeAndReason(statusCode, reasonPhrase ?? i18n.unknown)),
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
