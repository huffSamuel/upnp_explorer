import 'package:flutter/material.dart';

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
