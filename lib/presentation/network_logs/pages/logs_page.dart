import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/ioc.dart';
import '../../../application/network_logs/network_event_service.dart';
import '../../../application/routing/routes.dart';
import '../../../libraries/simple_upnp/src/upnp.dart' hide State;
import '../widgets/log_item.dart';
import 'filters_page.dart';
import 'log_page.dart';

class LogsPage extends StatefulWidget {
  const LogsPage();

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>
    with SingleTickerProviderStateMixin {
  final _repo = sl<NetworkEventService>();

  AppLocalizations get i18n => AppLocalizations.of(context)!;

  void _clear(BuildContext context, AppLocalizations i18n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(i18n.clearMessages),
        content: Text(i18n.thisWillClearAllMessages),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(i18n.keepHistory),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(i18n.clearHistory),
          ),
        ],
      ),
    ).then((r) {
      if (r != true) {
        return;
      }

      _repo.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _onLogCardTapped(BuildContext context, UPnPEvent event) {
    Navigator.of(context).push(
      makeRoute(
        context,
        LogPage(
          event: event,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.messages),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_rounded),
            tooltip: i18n.filter,
            onPressed: () =>
                Navigator.of(context).push(makeRoute(context, FiltersPage())),
          ),
          IconButton(
            icon: Icon(Icons.delete_forever_outlined),
            tooltip: i18n.clearAll,
            onPressed: () => _clear(
              context,
              i18n,
            ),
          ),
        ],
      ),
      body: Scrollbar(
        child: StreamBuilder(
            stream: _repo.events,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Container();
              }

              if (snapshot.data!.isEmpty) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => LogItem(
                  event: snapshot.data![index],
                  onTap: () => _onLogCardTapped(context, snapshot.data![index]),
                ),
                separatorBuilder: (_, __) => Divider(),
              );
            }),
      ),
    );
  }
}
