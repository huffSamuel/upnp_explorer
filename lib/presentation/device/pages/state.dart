import 'package:upnp_explorer/packages/upnp/upnp.dart';

class DiscoveryState {
  final bool wifi;
  final bool loading;
  final bool scanning;
  final List<UPnPDevice> devices;

  DiscoveryState({
    this.wifi = false,
    this.loading = false,
    this.scanning = false,
    required this.devices,
  });

  DiscoveryState copyWith({
    bool? wifi,
    bool? loading,
    bool? scanning,
    List<UPnPDevice>? devices,
  }) {
    return DiscoveryState(
      loading: loading ?? this.loading,
      wifi: wifi ?? this.wifi,
      scanning: scanning ?? this.scanning,
      devices: devices ?? this.devices,
    );
  }
}
