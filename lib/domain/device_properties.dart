class DeviceProperties {
  String locationData;
  String friendlyName;
  String imageUrl;
  String manufacturer;
  String model;

  Uri imageUri() {
    var location = Uri.parse(locationData);

    if (locationData == null || imageUrl == null) {
      return null;
    }

    return Uri(
        scheme: location.scheme,
        host: location.host,
        port: location.port,
        pathSegments: ['setup', 'icon.png']);
  }
}
