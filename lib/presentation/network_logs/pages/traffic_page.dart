import 'package:flutter/material.dart';

import '../../../application/ioc.dart';
import '../../../application/l10n/generated/l10n.dart';
import '../../../application/network_logs/network_logs_repository.dart';
import '../../../domain/network_logs/traffic.dart';
import '../../core/widgets/model_binding.dart';
import '../widgets/traffic_filter.dart';
import '../widgets/traffic_item_list.dart';

class TrafficPage extends StatefulWidget {
  @override
  State<TrafficPage> createState() => _TrafficPageState();
}

class _TrafficPageState extends State<TrafficPage>
    with SingleTickerProviderStateMixin {
  late final List<Traffic> _allItems;

  final _repo = sl<NetworkLogsRepository>();

  S get i18n => S.of(context);

  void _clear() {
    _repo.clear();
    
    setState(() {
      _allItems.clear();
    });
  }

  @override
  void initState() {
    _allItems = _repo.getAll();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: TrafficFilter.all(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).traffic),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.sort_rounded),
            //   onPressed: _filter,
            //   tooltip: 'Filter',
            // ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Text('Clear'),
                ),
              ],
              onSelected: (value) {
                if (value == 0) {
                  _clear();
                }
              },
            ),
          ],
        ),
        body: TrafficItems(
          items: _allItems,
        ),
      ),
    );
  }
}
