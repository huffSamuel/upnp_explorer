class SearchTarget {
  final String _field;

  const SearchTarget(this._field);

  /// Search for all devices and services.
  const SearchTarget.all() : this('ssdp:all');

  /// Search for root devices only.
  const SearchTarget.rootDevice() : this('upnp:rootdevice');

  /// Search for a particular device
  const SearchTarget.device(String uuid) : this('uuid:$uuid');

  /// Search for any device of this type where {deviceType} and {ver} are defined
  /// by the UPnP Forum working committee.
  const SearchTarget.deviceType(String deviceType, String ver)
      : this('urn:schemas-upnp-org:device:$deviceType:$ver');

  /// Search for any service of this type where {type} and {ver} are defined
  /// by the UPnP Forum working committee.
  const SearchTarget.serviceType(String type, String version)
      : this('urn:schemas-upnp-org:service:$type:$version');

  /// Search for any device of this type where {domain} (a Vendor Domain Name), {deviceType},
  /// and {ver} are defined by the UPnP vendor.
  SearchTarget.vendorDomain(String domain, String deviceType, String ver)
      : this('urn:${domain.replaceAll('.', '-')}:device:$deviceType:$ver');

  /// Search for any device of this type where {domain} (a Vendor Domain Name), {serviceType},
  /// and {ver} are defined by the UPnP vendor.
  SearchTarget.vendorService(String domain, String serviceType, String ver)
      : this('urn:${domain.replaceAll('.', '-')}:service:$serviceType:$ver');

  @override
  String toString() {
    return _field;
  }
}