import 'package:flutter/material.dart';
import '../widgets/clear_messages.dart';
import 'package:upnped/upnped.dart';

import '../../../../application/ioc.dart';
import '../../../../application/l10n/app_localizations.dart';
import '../../../../application/network_logs/network_event_service.dart';
import '../../../../application/routing/routes.dart';
import '../../../core/presentation/widgets/my_bottom_app_bar.dart';
import '../../../core/presentation/widgets/page_title.dart';
import 'log_page.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/log_item.dart';

class LogsPage extends StatefulWidget {
  const LogsPage();

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>
    with SingleTickerProviderStateMixin {
  final _service = sl<NetworkEventService>();

  AppLocalizations get i18n => AppLocalizations.of(context)!;

  void _clear(BuildContext context, AppLocalizations i18n) {
    showDialog(context: context, builder: (context) => ClearMessages())
        .then((r) {
      if (r != true) {
        return;
      }

      _service.clear();
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

  void _onLogCardTapped(BuildContext context, NetworkEvent event) {
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
      bottomNavigationBar: MyBottomAppBar(currentIndex: 1),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary),
          onPressed: Navigator.of(context).pop,
        ),
        title: PageTitle(child: Text('Messages')),
        actions: [
          FilterButton(),
          IconButton(
            icon: Icon(Icons.delete_sweep),
            tooltip: i18n.clearAll,
            onPressed: () => _clear(
              context,
              i18n,
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Scrollbar(
          child: StreamBuilder(
            stream: _service.events,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(child: Text('error'));
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Container(child: Text('No data'));
              }

              return ListView.builder(
                primary: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => LogItem(
                  event: snapshot.data![index],
                  onTap: () => _onLogCardTapped(context, snapshot.data![index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return IconButton(
      icon: Icon(Icons.filter_list_rounded),
      tooltip: i18n.filter,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (c) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom),
              child: FilterSheet(),
            );
          },
        );
      },
    );
  }
}
