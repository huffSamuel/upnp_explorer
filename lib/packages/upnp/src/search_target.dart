part of upnp;

class SearchTarget {
  static all() => 'ssdp:all';
  static rootDevice() => 'upnp:rootdevice';
  static device(String uuid) => 'uuid:$uuid';
  static deviceType(String deviceType, String ver) =>
      ('urn:schemas-upnp-org:device:$deviceType:$ver');
  static serviceType(String serviceType, String ver) =>
      ('urn:schemas-upnp-org:service:$serviceType:$ver');
  static vendorDomain(String domain, String deviceType, String ver) =>
      ('urn:${domain.replaceAll('.', '-')}:device:$deviceType:$ver');
  static vendorService(String domain, String serviceType, String ver) =>
      ('urn:${domain.replaceAll('.', '-')}:service:$serviceType:$ver');
}
