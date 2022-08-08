import 'package:xml/xml.dart';

class DeviceDescription {
  final String namespace;
  // final String pnpx; - Plug and Play extensions https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-rxad/9225d145-6b2c-40d5-8ee8-7d837379fc25
  // final String df; - Device Foundation for PnPX
  final Device device;
  final SpecVersion specVersion;

  DeviceDescription({
    required this.namespace,
    required this.device,
    required this.specVersion,
  });

  static fromXml(XmlDocument xml) {
    return DeviceDescription(
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

listOf<T>(XmlNode? xml, String elementType, T Function(XmlNode) buildFn) =>
    xml?.findAllElements(elementType).map<T>(buildFn).toList() ?? [];

class Device {
  final _DeviceType deviceType;
  final String friendlyName;
  final String manufacturer;
  final Uri? manufacturerUrl;
  final String? modelDescription;
  final String modelName;
  final String? modelNumber;
  final Uri? modelUrl;
  final String? serialNumber;
  final String udn;
  final String? upc;
  final _IconList iconList;
  final ServiceList serviceList;
  final DeviceList deviceList;
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

  static fromXml(XmlNode xml) {
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

class SpecVersion {
  final int major;
  final int minor;

  SpecVersion({
    required this.major,
    required this.minor,
  });

  static fromXml(XmlNode node) {
    return SpecVersion(
      major: int.parse(node.getElement('major')!.text),
      minor: int.parse(node.getElement('minor')!.text),
    );
  }
}

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
  final String serviceType;
  final _ServiceId serviceId;
  final Uri scpdurl;
  final Uri controlUrl;
  final Uri eventSubUrl;

  Service({
    required this.serviceType,
    required this.serviceId,
    required this.scpdurl,
    required this.controlUrl,
    required this.eventSubUrl,
  });

  static fromXml(XmlNode xml) {
    final scpdurl = xml.getElement('SCPDURL')?.text;
    final controlUrl = xml.getElement('controlURL')?.text;
    final eventSubUrl = xml.getElement('eventSubURL')?.text;

    return Service(
      serviceType: xml.getElement('serviceType')!.text,
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

class _IconList {
  final List<DeviceIcon> icons;

  _IconList({
    required this.icons,
  });

  static fromXml(XmlNode? xml) {
    return _IconList(
      icons: xml
              ?.findAllElements('icon')
              ?.map<DeviceIcon>((x) => DeviceIcon.fromXml(x))
              ?.toList() ??
          [],
    );
  }
}

class DeviceIcon {
  final String mimeType;
  final int width;
  final int height;
  final String depth;
  final Uri url;

  DeviceIcon({
    required this.mimeType,
    required this.width,
    required this.height,
    required this.depth,
    required this.url,
  });

  static fromXml(XmlNode xml) {
    return DeviceIcon(
      mimeType: xml.getElement('mimetype')!.text,
      width: int.parse(xml.getElement('width')!.text),
      height: int.parse(xml.getElement('height')!.text),
      depth: xml.getElement('depth')!.text,
      url: Uri.parse(xml.getElement('url')!.text),
    );
  }
}
