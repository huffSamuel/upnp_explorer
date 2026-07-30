import 'package:flutter/material.dart';

import '../../../../application/ioc.dart';
import '../../../../extension/build_context.dart';
import '../../../core/presentation/widgets/page_title.dart';
import '../../logic/service.dart';
import '../widgets/loaded_list.dart';
import '../widgets/refresh_button.dart';

class ExplorerPage extends StatefulWidget {
  final DiscoveryStateService _service;

  ExplorerPage({
    super.key,
    DiscoveryStateService? service,
  })  : _service = service ?? sl<DiscoveryStateService>();
  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = context.i18n();

    final actions = [
      RefreshIconButton(
        service: widget._service,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: PageTitle(
          child: Row(
            children: [
              Icon(Icons.hub),
              SizedBox(width: 10),
              Text(i18n.explorer),
            ],
          ),
        ),
        actions: actions,
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget._service.state,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.hasError ||
                snapshot.data!.loading) {
              return const SizedBox();
            }

            return LoadedList(
              onRefresh: widget._service.search,
              scanning: snapshot.data!.scanning,
              devices: snapshot.data!.devices,
              noNetwork: !snapshot.data!.viableNetwork,
            );
          },
        ),
      ),
    );
  }
}
