import 'package:flutter/material.dart';
import '../../../simple_upnp/src/upnp.dart';

class _HttpRequestLogContent extends StatelessWidget {
  final HttpRequestEvent event;

  const _HttpRequestLogContent({super.key, required this.event});

  String _headers(Map<String, String> headers) {
    var sb = StringBuffer();

    headers.forEach((k, v) => sb.writeln('$k: $v'));

    return sb.toString();
  }

  Widget _body(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: ElevationOverlay.applySurfaceTint(
          colorScheme.surface,
          colorScheme.surfaceTint,
          4,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SelectableText(
        text,
        style: Theme.of(context).textTheme.bodySmall!,
      ),
    );
  }

  List<Widget> _request(BuildContext context) {
    return [
      Text('Request', style: TextStyle(fontWeight: FontWeight.w600)),
      SelectableText(
        _headers(event.request.headers).trim(),
        style: Theme.of(context).textTheme.bodySmall!,
      ),
      if (event.request.body.isNotEmpty) const SizedBox(height: 6.0),
      if (event.request.body.isNotEmpty) _body(context, event.requestBody),
    ];
  }

  List<Widget> _response(BuildContext context) {
    return [
      Text('Response', style: TextStyle(fontWeight: FontWeight.w600)),
      SelectableText(
        _headers(event.response.headers).trim(),
        style: Theme.of(context).textTheme.bodySmall!,
      ),
      const SizedBox(height: 6.0),
      _body(context, event.responseBody),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${event.response.statusCode} - ${event.response.reasonPhrase}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12.0),
        ..._request(context),
        const SizedBox(height: 12.0),
        ..._response(context),
      ],
    );
  }
}

class LogContent extends StatelessWidget {
  final UPnPEvent event;

  const LogContent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    if (event is HttpRequestEvent) {
      return _HttpRequestLogContent(event: event as HttpRequestEvent);
    }

    return SelectableText(
      event.content,
      style: Theme.of(context).textTheme.bodySmall!,
    );
  }
}
