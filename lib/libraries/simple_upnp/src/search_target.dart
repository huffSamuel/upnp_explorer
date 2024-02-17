part of simple_upnp;

class SearchTarget {
  /// All devices and services.
  static const all = 'ssdp:all';

  /// Root devices only.
  static const rootDevice = 'upnp:rootdevice';

  /// A particular device.
  static device(String uuid) => 'uuid:$uuid';

  /// A device of the specified type and version defined by the UPnP Forum.
  static deviceType(String deviceType, String ver) =>
      ('urn:schemas-upnp-org:device:$deviceType:$ver');

  /// A service of the specified type and version by the UPnp Forum.
  static serviceType(String serviceType, String ver) =>
      ('urn:schemas-upnp-org:service:$serviceType:$ver');

  /// A device of the specified type with the provided vendor domain.
  static vendorDomain(String domain, String deviceType, String ver) =>
      ('urn:${domain.replaceAll('.', '-')}:device:$deviceType:$ver');

  /// A service of the specified type with the provided vendor domain.
  static vendorService(String domain, String serviceType, String ver) =>
      ('urn:${domain.replaceAll('.', '-')}:service:$serviceType:$ver');
}
