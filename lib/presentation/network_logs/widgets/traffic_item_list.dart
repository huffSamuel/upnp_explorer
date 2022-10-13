import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

import '../../../domain/network_logs/traffic.dart';
import '../../../infrastructure/upnp/device_discovery_service.dart';
import '../../../infrastructure/upnp/ssdp_response_message.dart';
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

  List<Traffic<dynamic>> _visibleItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final filter = ModelBinding.of<TrafficFilter>(context);

    setState(() {
      _visibleItems = widget.items.where((x) => filter.permit(x)).toList();
    });
  }

  Widget _map(Traffic traffic) {
    String text = '';
    String origin = '';

    if (traffic is Traffic<SearchRequest>) {
      text = traffic.message.request.toString();
      origin = traffic.message.address;
    }

    if (traffic is Traffic<SSDPResponseMessage>) {
      text = traffic.message.toString();
      origin = traffic.message.location.authority;
    }

    if (traffic is Traffic<Response>) {
      text = _responseToString(traffic.message);
      origin = traffic.message.request!.url.authority;
    }

    return LogCard(
      onFilter: _filter,
      time: traffic.dateTime,
      direction: traffic.direction,
      protocol: traffic.protocol,
      origin: origin,
      text: text,
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
      child: AutomaticAnimatedList(
        controller: _scrollController,
        items: _visibleItems,
        keyingFunction: (item) => Key(item.hashCode.toString()),
        itemBuilder: (
          BuildContext context,
          Traffic<dynamic> item,
          Animation<double> animation,
        ) {
          return FadeTransition(
            key: Key(item.hashCode.toString()),
            opacity: animation.drive(
              Tween(
                begin: 0.0,
                end: 1.0,
              ),
            ),
            child: _map(item),
          );
        },
      ),
    );
  }
}

class _SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final _controller = ScrollController();
  final List<String> filters;
  _SliverFilterHeaderDelegate({
    required this.vsync,
    required this.filters,
  }) : super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: ListView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: [
            ...filters.map(
              (x) => FilterChip(
                label: Text(x),
                selected: true,
                onSelected: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => 25;

  @override
  TickerProvider vsync;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
          curve: Curves.ease, duration: const Duration(milliseconds: 300));
}

String _responseToString(Response response) {
  final headers = response.headers.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));

  return '''
HTTP/1.1 ${response.statusCode}
${headers.map((x) => '${x.key}: ${x.value}').join('\n')}\n
${response.body}
''';
}
