import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';

import '../../../packages/upnp/upnp.dart';
import '../../core/widgets/model_binding.dart';
import 'log_card.dart';
import 'log_details_dialog.dart';
import 'traffic_filter.dart';

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

  List<NetworkMessage> _visibleItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final filter = ModelBinding.of<TrafficFilter>(context);

    setState(() {
      _visibleItems = widget.items.where((x) => filter.permit(x)).toList();
    });
  }

  Widget _map(NetworkMessage traffic) {
    final children = <Widget>[];

    if (traffic is SearchRequest) {
      children.addAll([
        Text(
          'Search Request',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        MessageBlock(
          traffic.content,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => LogDetailsDialog(
                text: traffic.content,
                title: 'Search Request',
              ),
            );
          },
        ),
      ]);
    } else if (traffic is NotifyResponse) {
      children.addAll([
        Text('from ' + traffic.uri),
        Text(
          'Notify Response',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        MessageBlock(
          traffic.content,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => LogDetailsDialog(
                text: traffic.content,
                title: 'Notify Response',
              ),
            );
          },
        ),
      ]);
    } else if (traffic is InvokeActionRequest) {
      children.addAll([
        Text('to ' + traffic.uri),
        Text(
            'returned ' + traffic.status.toString() + ' Internal Server Error'),
        Text(
          'Request Body',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        MessageBlock(
          traffic.requestBody,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => LogDetailsDialog(
                text: traffic.requestBody,
                title: 'Request Body',
              ),
            );
          },
        ),
        Text(
          'Response Body',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        MessageBlock(
          traffic.responseBody,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => LogDetailsDialog(
                text: traffic.responseBody,
                title: 'Response Body',
              ),
            );
          },
        ),
      ]);
    } else if (traffic is HttpMessage) {
      children.addAll([
        Text('to ' + traffic.request.url.toString()),
        Text(
          'Response Body',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        MessageBlock(
          traffic.response.body,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => LogDetailsDialog(
                text: traffic.response.body,
                title: 'Response Body',
              ),
            );
          },
        ),
      ]);
    }

    return LogCard(
      onFilter: _filter,
      time: traffic.time,
      direction: traffic.direction,
      protocol: traffic.protocol,
      children: children,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _filter(TrafficFilter filter) {
    ModelBinding.update<TrafficFilter>(context, filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ImplicitlyAnimatedList<NetworkMessage>(
        controller: _scrollController,
        items: _visibleItems,
        areItemsTheSame: (a, b) => a == b,
        insertDuration: Duration(milliseconds: 150),
        removeDuration: Duration.zero,
        itemBuilder: (context, animation, item, index) => SizeTransition(
          sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
          child: _map(item),
        ),
      ),
    );
  }
}

class MessageBlock extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  MessageBlock(
    this.message, {
    required this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 6,
        ),
        width: double.infinity,
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 3,
        ),
      ),
    );
  }
}
