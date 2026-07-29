import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLink extends StatelessWidget {
  final Uri? url;
  final Widget child;

  const ExternalLink({
    super.key,
    this.url,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return child;
    }

    return GestureDetector(
      onTap: () {
        if (url == null) {
          return;
        }

        launchUrl(url!);
      },
      child: Row(
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.open_in_new,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withAlpha((.6 * 255).toInt()),
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
