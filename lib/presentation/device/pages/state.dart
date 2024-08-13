import 'package:upnped/upnped.dart';

class DiscoveryState {
  /// Indicates if the device is connected to a network that is viable for UPnP scanning.
  final bool viableNetwork;

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
    this.viableNetwork = false,
    this.loading = false,
    this.scanning = false,
    required this.devices,
  });

  DiscoveryState copyWith({
    bool? viableNetwork,
    bool? loading,
    bool? scanning,
    List<Device>? devices,
  }) {
    return DiscoveryState(
      loading: loading ?? this.loading,
      viableNetwork: viableNetwork ?? this.viableNetwork,
      scanning: scanning ?? this.scanning,
      devices: devices ?? this.devices,
    );
  }
}
