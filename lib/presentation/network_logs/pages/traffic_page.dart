import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/packages/upnp/upnp.dart';

import '../../../application/ioc.dart';
import '../../../domain/network_logs/network_logs_repository_type.dart';
import '../widgets/traffic_item_list.dart';

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

  void _clear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Messages?'),
        content: Text('This will clear all network message history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No, keep history'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).buttonTheme.colorScheme!.tertiaryContainer,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes, clear history'),
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
    super.initState();
    _messageSubscription = _repo.messages.listen(_onMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            tooltip: 'Clear All',
            onPressed: () => _clear(context),
          ),
          // IconButton(
          //   icon: Icon(Icons.filter_list_rounded),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: TrafficItems(
        items: _messages,
      ),
    );
  }
}
