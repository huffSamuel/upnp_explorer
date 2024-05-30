import 'package:upnped/upnped.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/routing/routes.dart';
import '../../core/page/app_page.dart';
import 'action_page.dart';

class ServicePage extends StatelessWidget {
  final Service service;
  final unlocked = true;

  const ServicePage({
    Key? key,
    required this.service,
  }) : super(key: key);

  Widget _icon(BuildContext context) {
    return Icon(unlocked ? Icons.chevron_right : Icons.lock_outline);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    final actions = [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: Text(i18n.viewInBrowser),
          )
        ],
        onSelected: (value) {
          if (value == 0) {
            launchUrl(service.location);
          }
        },
      ),
    ];

    final children = service.description == null ||
            service.description!.actions.isEmpty == true
        ? [NothingHere()]
        : List<Widget>.of(
            service.description!.actions.map(
              (x) {
                return ListTile(
                  title: Text(x.name),
                  trailing: _icon(context),
                  onTap: () => Navigator.of(context).push(
                    makeRoute(
                      context,
                      ActionPage(
                        action: x,
                        stateTable: service.description!.serviceStateTable,
                      ),
                    ),
                  ),
                );
              },
            ),
          );

    return AppPage(
      title: Text(service.document.serviceId.serviceId),
      children: children,
      actions: actions,
    );
  }
}

class NothingHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32.0),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: const Border.fromBorderSide(
                BorderSide(
                  width: 2,
                ),
              ),
            ),
            child: const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.question_mark_rounded,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          Text(i18n.nothingHere)
        ],
      ),
    );
  }
}
