import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:xml/xml.dart';

import '../../domain/device/device.dart';
import '../../domain/device/device_repository_type.dart';
import '../../domain/device/service_repository_type.dart';
import '../core/download_service.dart';
import '../core/logger_factory.dart';
import '../upnp/device.dart';
import '../upnp/service_description.dart';
import '../upnp/ssdp_response_message.dart';
import 'device_discovery_service.dart';

class SocketOptions {
  final InternetAddress address;
  final InternetAddress multicastAddress;
  SocketOptions(this.address, this.multicastAddress);
}

@Singleton()
class SSDPService {
  final controller = StreamController<UPnPDevice>.broadcast();

  final DownloadService download;
  final DeviceDiscoveryService discovery;
  final Logger logger;
  final DeviceRepositoryType deviceRepository;
  final ServiceRepositoryType serviceRepository;

  Stream<UPnPDevice> get stream => controller.stream;

  SSDPService(
    this.discovery,
    this.download,
    LoggerFactory loggerFactory,
    @Named('DeviceRepository') this.deviceRepository,
    @Named('ServiceRepository') this.serviceRepository,
  ) : logger = loggerFactory.build('SSDPService') {
    discovery.responses.listen(
      _onData,
      onDone: () {
        controller.close();
      },
      onError: (err) {
        controller.addError(err);
      },
    );
  }

  _addDevice(Uri root, Device device) async {
    deviceRepository.insert(device);

    for (final service in device.serviceList.services) {
      final downloadUri = new Uri(
        scheme: root.scheme,
        host: root.host,
        port: root.port,
        pathSegments: service.scpdurl.pathSegments,
      );
      final serviceDescription = await download.get(downloadUri);

      serviceRepository.insert(
        service.serviceId.toString(),
        ServiceDescription.fromXml(
          XmlDocument.parse(serviceDescription),
        ),
      );
    }

    for(final child in device.deviceList.devices) {
      await _addDevice(root, child);
    }
  }

  _onData(SSDPResponseMessage event) async {
    final document = await download.get(event.location);
    final xmlDocument = XmlDocument.parse(document);

    final rootDocument = DeviceDescription.fromXml(xmlDocument);

    final device = UPnPDevice(event, rootDocument);

    logger.information(
      'Discovered device',
      {
        'friendlyName': device.description.device.friendlyName,
        'model': device.description.device.modelName,
        'manufacturer': device.description.device.manufacturer,
      },
    );

    await _addDevice(event.location, device.description.device);

    controller.add(device);
  }

  Stream<UPnPDevice> findDevices() {
    if (!discovery.isInitialized) {
      discovery.init().then((_) => discovery.search());
    } else {
      discovery.search();
    }

    return stream;
  }
}
