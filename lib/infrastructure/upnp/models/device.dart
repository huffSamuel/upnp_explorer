import 'package:xml/xml.dart';

import 'spec_version.dart';

class DeviceDescription {
  final XmlDocument xml;
  final String namespace;
  // final String pnpx; - Plug and Play extensions https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-rxad/9225d145-6b2c-40d5-8ee8-7d837379fc25
  // final String df; - Device Foundation for PnPX
  final Device device;
  final SpecVersion specVersion;

  DeviceDescription(
    this.xml, {
    required this.namespace,
    required this.device,
    required this.specVersion,
  });

  @override
  toString() {
    return xml.toString();
  }

  static DeviceDescription fromXml(XmlDocument xml) {
    return DeviceDescription(
      xml,
      namespace: xml.rootElement.attributes
          .where((x) => x.qualifiedName == 'xmlns')
          .single
          .value,
      device: Device.fromXml(xml.rootElement.getElement('device')!),
      specVersion:
          SpecVersion.fromXml(xml.rootElement.getElement('specVersion')!),
    );
  }
}

class Device {
  /// UPnP device type.
  final _DeviceType deviceType;

  /// Short description for end user.
  final String friendlyName;

  /// Manufacturer's name.
  final String manufacturer;

  /// Web site for [manufacturer].
  final Uri? manufacturerUrl;

  /// Long description for end user.
  final String? modelDescription;

  /// Model name.
  final String modelName;

  /// Model number.
  final String? modelNumber;

  /// Web site for model.
  final Uri? modelUrl;

  /// Serial number.
  final String? serialNumber;

  /// Unique device name.
  ///
  /// A universally-unique identifier for the device, whether root or embedded.
  final String udn;

  /// Universal product code.
  ///
  /// A 12-digit, all numeric code that identifies the consumer packages.
  final String? upc;

  /// List of icons that visually represent this device.
  final _IconList iconList;

  /// List of services available on this device.
  final ServiceList serviceList;

  /// List of child devices on this device.
  final DeviceList deviceList;

  /// URL to presentation for this device.
  final Uri? presentationUrl;

  Device({
    required this.deviceType,
    required this.friendlyName,
    required this.manufacturer,
    this.manufacturerUrl,
    this.modelDescription,
    required this.modelName,
    this.modelNumber,
    this.modelUrl,
    this.serialNumber,
    required this.udn,
    this.upc,
    required this.iconList,
    required this.serviceList,
    required this.deviceList,
    this.presentationUrl,
  });

  static List<Device> listFromXmlNode(XmlNode? xml) {
    return xml
            ?.findAllElements('device')
            .map<Device>((e) => Device.fromXml(e))
            .toList() ??
        [];
  }

  static Device fromXml(XmlNode xml) {
    final presentationUrl = xml.getElement('presentationURL');

    final modelUrl = xml.getElement('modelURL');
    final manufacturerUrl = xml.getElement('manufacturerURL');

    return Device(
      deviceType: _DeviceType.parse(xml.getElement('deviceType')!.text),
      friendlyName: xml.getElement('friendlyName')!.text,
      manufacturer: xml.getElement('manufacturer')!.text,
      manufacturerUrl:
          manufacturerUrl != null ? Uri.parse(manufacturerUrl.text) : null,
      modelDescription: xml.getElement('modelDescription')?.text,
      modelName: xml.getElement('modelName')!.text,
      modelNumber: xml.getElement('modelNumber')?.text,
      modelUrl: modelUrl != null ? Uri.parse(modelUrl.text) : null,
      serialNumber: xml.getElement('serialNumber')?.text,
      udn: xml.getElement('UDN')!.text,
      upc: xml.getElement('UPC')?.text,
      iconList: _IconList.fromXml(xml.getElement('iconList')),
      serviceList: ServiceList.fromXml(xml.getElement('serviceList')),
      deviceList: DeviceList.fromXml(xml.getElement('deviceList')),
      presentationUrl:
          presentationUrl != null ? Uri.parse(presentationUrl.text) : null,
    );
  }
}

class _DeviceType {
  final String urn;
  final String type;
  final int version;

  _DeviceType({
    required this.urn,
    required this.type,
    required this.version,
  });

  static parse(String str) {
    final fields = str.split(':');

    return _DeviceType(
      urn: fields[1],
      type: fields[3],
      version: int.parse(fields[4]),
    );
  }
}

@deprecated
class DeviceList {
  final List<Device> devices;

  DeviceList({
    required this.devices,
  });

  static fromXml(XmlNode? xml) {
    return DeviceList(
      devices: xml
              ?.findAllElements('device')
              .map<Device>((e) => Device.fromXml(e))
              .toList() ??
          [],
    );
  }
}

@deprecated
class ServiceList {
  final List<Service> services;

  ServiceList({
    required this.services,
  });

  static fromXml(XmlNode? xml) {
    return ServiceList(
      services: xml
              ?.findAllElements('service')
              .map<Service>((x) => Service.fromXml(x))
              .toList() ??
          [],
    );
  }
}

class Service {
  /// UPnP service type.
  final String serviceType;

  ///
  final String serviceVersion;

  /// Service identifier.
  final _ServiceId serviceId;

  /// URL for service description.
  final Uri scpdurl;

  /// URL for control.
  final Uri controlUrl;

  /// URL for eventing.
  final Uri eventSubUrl;

  Service({
    required this.serviceType,
    required this.serviceVersion,
    required this.serviceId,
    required this.scpdurl,
    required this.controlUrl,
    required this.eventSubUrl,
  });

  static List<Service> listFromXmlNode(XmlNode? xml) {
    return xml
            ?.findAllElements('service')
            .map<Service>((x) => Service.fromXml(x))
            .toList() ??
        [];
  }

  static Service fromXml(XmlNode xml) {
    final scpdurl = xml.getElement('SCPDURL')?.text;
    final controlUrl = xml.getElement('controlURL')?.text;
    final eventSubUrl = xml.getElement('eventSubURL')?.text;
    final serviceType = xml.getElement('serviceType')!.text;

    final serviceTypeFields = serviceType.split(':');

    return Service(
      serviceType: serviceTypeFields[serviceTypeFields.length - 2],
      serviceVersion: serviceTypeFields[serviceTypeFields.length - 1],
      serviceId: _ServiceId.parse(xml.getElement('serviceId')!.text),
      scpdurl: Uri.parse(scpdurl!),
      controlUrl: Uri.parse(controlUrl!),
      eventSubUrl: Uri.parse(eventSubUrl!),
    );
  }
}

class _ServiceId {
  final String _fields;
  final String domain;
  final String serviceId;

  _ServiceId(
    this._fields, {
    required this.domain,
    required this.serviceId,
  });

  static parse(String str) {
    final fields = str.split(':');

    return _ServiceId(
      str,
      domain: fields[1],
      serviceId: fields[3],
    );
  }

  @override
  String toString() {
    return _fields;
  }
}

@deprecated
class _IconList {
  final List<DeviceIcon> icons;

  _IconList({
    required this.icons,
  });

  static fromXml(XmlNode? xml) {
    return _IconList(
      icons: xml
              ?.findAllElements('icon')
              .map<DeviceIcon>((x) => DeviceIcon.fromXml(x))
              .toList() ??
          [],
    );
  }
}

class DeviceIcon {
  /// Icon's MIME type.
  final String mimeType;

  /// Horizontal dimension of the icon, in pixels.
  final int width;

  /// Vertical dimensions of the icon, in pixels.
  final int height;

  /// Number of color bits per pixel.
  final String depth;

  /// Pointer to the icon image.
  ///
  /// Relative to the URL at which the device description is located.
  final Uri url;

  DeviceIcon({
    required this.mimeType,
    required this.width,
    required this.height,
    required this.depth,
    required this.url,
  });

  static List<DeviceIcon> listFromXmlNode(XmlNode? xml) {
    return xml
            ?.findAllElements('icon')
            .map<DeviceIcon>((x) => DeviceIcon.fromXml(x))
            .toList() ??
        [];
  }

  static DeviceIcon fromXml(XmlNode xml) {
    return DeviceIcon(
      mimeType: xml.getElement('mimetype')!.text,
      width: int.parse(xml.getElement('width')!.text),
      height: int.parse(xml.getElement('height')!.text),
      depth: xml.getElement('depth')!.text,
      url: Uri.parse(xml.getElement('url')!.text),
    );
  }
}
