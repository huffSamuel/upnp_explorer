import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../application/ioc.dart';
import '../../../domain/network_logs/network_logs_repository_type.dart';
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

  final _repo = sl<NetworkLogsRepositoryType>();

  AppLocalizations get i18n => AppLocalizations.of(context)!;

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
          title: Text(i18n.traffic),
          actions: [
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
