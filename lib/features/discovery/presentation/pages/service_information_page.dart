import 'package:flutter/material.dart';
import 'package:upnped/upnped.dart';

import '../../../../extension/build_context.dart';
import '../../../control/presentation/pages/action_page.dart';
import '../../../core/presentation/widgets/list_tile_splash_host.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../widgets/item_list_card.dart';

class ServiceInformationPage extends StatelessWidget {
  final Service service;

  const ServiceInformationPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = context.i18n();

    final actions = service.description?.actions ?? [];
    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          child: Text(i18n.serviceDetails),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8),
            child: Text(
              service.document.serviceType,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -.3,
                  ),
            ),
          ),
          const SizedBox(height: 24),
          if (actions.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(i18n.noActions),
              ],
            ),
          if (actions.isNotEmpty)
            ItemListCard(
              items: actions,
              title: Row(children: [
                Icon(Icons.auto_awesome_motion,
                    color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 12),
                Text(
                  i18n.actions,
                  style: TextTheme.of(context).bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -.3,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ]),
              itemBuilder: (c, i) => ListTileSplashHost(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(i.name),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ActionPage(
                          action: i,
                          serviceStateTable:
                              service.description!.serviceStateTable,
                        ),
                      ),
                    );
                  },
                  visualDensity: VisualDensity.compact,
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
