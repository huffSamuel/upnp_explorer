import 'package:flutter/material.dart';

import '../../../domain/network_logs/traffic.dart';
import '../../core/widgets/animated_filter_list.dart';
import '../../core/widgets/model_binding.dart';
import 'log_card.dart';
import 'traffic_filter.dart';

class TrafficItems extends StatefulWidget {
  final List<Traffic> items;

  const TrafficItems({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<TrafficItems> createState() => _TrafficItemsState();
}

class _TrafficItemsState extends State<TrafficItems> {
  final _scrollController = ScrollController();

  List<Traffic> _visibleItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final filter = ModelBinding.of<TrafficFilter>(context);

    setState(() {
      _visibleItems = widget.items.where((x) => filter.permit(x)).toList();
    });
  }

  Widget _map(Traffic traffic) => LogCard(
        onFilter: _filter,
        time: traffic.dateTime,
        direction: traffic.direction,
        protocol: traffic.protocol,
        origin: traffic.origin,
        text: traffic.message,
      );

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
      child: AutomaticAnimatedList(
        controller: _scrollController,
        items: _visibleItems,
        keyingFunction: (item) => Key(item.hashCode.toString()),
        itemBuilder: (
          BuildContext context,
          Traffic item,
          Animation<double> animation,
        ) {
          return ScaleTransition(
            scale: animation.drive(
              Tween(begin: 0.0, end: 1.0),
            ),
            key: Key(item.hashCode.toString()),
            child: _map(item),
          );
        },
      ),
    );
  }
}
