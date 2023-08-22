import 'package:flutter/material.dart';

class DevicePageNavigationBar extends StatefulWidget {
  final TabController? controller;

  const DevicePageNavigationBar({
    super.key,
    this.controller,
  });

  @override
  State<DevicePageNavigationBar> createState() =>
      _DevicePageNavigationBarState();
}

class _DevicePageNavigationBarState extends State<DevicePageNavigationBar> {
  TabController? _controller;

  @override
  void dispose() {
    _controller?.removeListener(_handleControllerTick);

    super.dispose();
  }

  bool get _isControllerValid => _controller?.animation != null;

  didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
  }

  @override
  didUpdateWidget(DevicePageNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
    }
  }

  _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.maybeOf(context);

    assert(() {
      if (newController == null) {
        throw Error();
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }

    if (_isControllerValid) {
      _controller!.removeListener(_handleControllerTick);
    }

    _controller = newController;

    if (_controller != null) {
      _controller!.addListener(_handleControllerTick);
    }
  }

  _handleControllerTick() {
    setState(() {
      // Trigger the rebuild with the controller's index
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _controller!.index,
      onTap: _controller!.animateTo,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.device_hub_rounded),
          label: 'Devices',
        ),
      ],
    );
  }
}
