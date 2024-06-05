import 'package:upnped/upnped.dart';

class DiscoveryState {
  /// Indicates if the device is connected to a WiFi network.
  final bool wifi;

  /// Indicates the state is in the initial loading state.
  final bool loading;

  /// Indicates a device scan is currently under way.
  final bool scanning;

  /// All devices discovered in the most recent scan.
  ///
  /// This value will update during a scan when additional devices are discovered
  /// or asynchronously when UPnP devices emit NOTIFY events.
  final List<Device> devices;

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
    List<Device>? devices,
  }) {
    return DiscoveryState(
      loading: loading ?? this.loading,
      wifi: wifi ?? this.wifi,
      scanning: scanning ?? this.scanning,
      devices: devices ?? this.devices,
    );
  }
}
