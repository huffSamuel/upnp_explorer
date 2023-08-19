import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/ioc.dart';
import '../../../application/network_logs/filter_state.dart';
import '../../../application/routing/routes.dart';
import '../../../domain/network_logs/network_logs_repository_type.dart';
import '../../../packages/upnp/upnp.dart';
import '../widgets/log_card.dart';
import '../widgets/network_message_dialog.dart';
import 'filters_page.dart';

class TrafficPage extends StatefulWidget {
  @override
  State<TrafficPage> createState() => _TrafficPageState();
}

class _TrafficPageState extends State<TrafficPage>
    with SingleTickerProviderStateMixin {
  final _repo = sl<NetworkLogsRepositoryType>();

  List<NetworkMessage> _messages = [];
  late StreamSubscription _messageSubscription;
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

      setState(() {
        _messages.clear();
      });
    });
  }

  void _onMessage(NetworkMessage message) {
    if (!mounted) {
      return;
    }

    setState(() {
      _messages.add(message);
    });
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _messageSubscription = _repo.messages.listen(_onMessage);
    super.initState();
  }

  void _onLogCardTapped(BuildContext context, NetworkMessage message) {
    if (message is HttpMessage) {
      showDialog(
        context: context,
        builder: (ctx) => HttpNetworkMessageDialog(
          message: message,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => NetworkMessageDialog(
        message: message,
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
            onPressed: () => _clear(context, i18n,),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            ...FilterState.of(context).filter(_messages).map(
                  (x) => LogCard(
                    onTap: () => _onLogCardTapped(context, x),
                    traffic: x,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
