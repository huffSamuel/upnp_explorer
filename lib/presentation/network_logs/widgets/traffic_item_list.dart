import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upnp_explorer/presentation/network_logs/widgets/network_message_dialog.dart';

import '../../../packages/upnp/upnp.dart';
import '../../core/widgets/model_binding.dart';
import 'log_card.dart';

class TrafficItems extends StatefulWidget {
  final List<NetworkMessage> items;

  const TrafficItems({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<TrafficItems> createState() => _TrafficItemsState();
}

class _TrafficItemsState extends State<TrafficItems> {
  final _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onLogCardTapped(BuildContext context, NetworkMessage message) {
    if (message is HttpMessage) {
      showDialog(
        context: context,
        builder: (ctx) => HttpNetworkMessageDialog(
            request: message.request as Request, response: message.response),
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ImplicitlyAnimatedList<NetworkMessage>(
        controller: _scrollController,
        items: widget.items,
        areItemsTheSame: (a, b) => a == b,
        insertDuration: Duration(milliseconds: 150),
        removeDuration: Duration.zero,
        itemBuilder: (context, animation, item, index) => SizeTransition(
          sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
          child: LogCard(
            onTap: () => _onLogCardTapped(context, item),
            traffic: item,
          ),
        ),
      ),
    );
  }
}