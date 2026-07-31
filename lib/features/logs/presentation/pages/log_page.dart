import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/ioc.dart';
import '../../../../extension/build_context.dart';
import '../../../control/presentation/widgets/my_field.dart';
import '../../../core/presentation/widgets/my_card.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../../core/presentation/widgets/section_header.dart';
import '../../../discovery/presentation/widgets/device_card.dart';
import '../../../discovery/service/device_service.dart';
import '../widgets/detail_section_card.dart';
import '../widgets/header_map.dart';
import '../widgets/source_code_card.dart';
import '../widgets/status_chip.dart';

class LogPage extends StatelessWidget {
  final DeviceService _service = sl<DeviceService>();

  final NetworkEvent event;
  LogPage({super.key, required this.event});

  bool _hasTarget() {
    return event is HttpEvent || event is NotifyEvent;
  }

  String _target() {
    return switch (event) {
      HttpEvent h => h.request.url.host,
      NotifyEvent n => n.uri.host,
      _ => ''
    };
  }

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
                  if (event is HttpEvent || event is NotifyEvent) ...[
                    Label(
                        label: Text('Source IP'),
                        style: TextStyle(fontSize: 14)),
                    Text(
                      (event is HttpEvent)
                          ? (event as HttpEvent).from!
                          : (event as NotifyEvent).uri.host,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theme.hintColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8)
                  ],
                  if (event is HttpEvent) ...[
                    Label(
                        label: Text('Target IP'),
                        style: TextStyle(fontSize: 14)),
                    Text(
                      (event as HttpEvent).request.url.host,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theme.hintColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
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
            if (_hasTarget())
              DeviceCard(
                  device: _service.devices.firstWhere(
                      (d) => d.notify?.location?.host == _target())),
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
              SourceCodeCard(
                title: Text(i18n.payload),
                sourceCode: (event as HttpEvent).request.body,
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
                (event as HttpEvent).response.body.isNotEmpty)
              SourceCodeCard(
                title: Text(i18n.responseBody),
                sourceCode: (event as HttpEvent).response.body,
              ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
