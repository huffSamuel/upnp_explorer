import 'dart:async';
import 'dart:io';

import 'package:xml/xml.dart';

import '../../domain/device.dart';
import '../../domain/device_document.dart';
import '../../domain/device_properties.dart';
import 'device_data_service.dart';
import 'device_discovery_service.dart';
import 'logging/logger_factory.dart';

class SocketOptions {
  final InternetAddress address;
  final InternetAddress multicastAddress;
  SocketOptions(this.address, this.multicastAddress);
}

const _kFriendlyNamePath = ['root', 'device', 'friendlyName'];
const _kXFriendlyNamePath = ['root', 'device', 'x-friendly-name'];
const _kImageUrlPath = ['root', 'device', 'iconList', 'icon', 'url'];
const _kManufacturerPath = ['root', 'device', 'manufacturer'];
const _kModelPath = ['root', 'device', 'modelName'];

class SSDPService {
  final controller = StreamController<Device>.broadcast();

  final DeviceDiscoveryService discovery;
  final DeviceDataService data;
  final Logger logger;

  SSDPService(this.discovery, this.data, LoggerFactory loggerFactory)
      : logger = loggerFactory.build('SSDPService') {
    discovery.stream.listen((event) async {
      final device = Device(event);
      final properties = DeviceProperties();

      properties.locationData = event.parsed['location'];
      String locationData;

      try {
        locationData = await data.download(event.parsed['location']);
      } catch (e) {
        logger.warning('Unable to download location data');
      }

      if (locationData != null) {
        try {
          final uri = Uri.parse(event.parsed['location']);
          final documents = await _getDocuments(uri);

          device.documents.addAll(documents);

          final mainDocument = device.documents.first.xmlDocument;

          properties.friendlyName = _getText(mainDocument, _kFriendlyNamePath);

          if (properties.friendlyName == null ||
              properties.friendlyName.isEmpty) {
            properties.friendlyName =
                _getText(mainDocument, _kXFriendlyNamePath);
          }

          properties.imageUrl = _getText(mainDocument, _kImageUrlPath);
          properties.manufacturer = _getText(mainDocument, _kManufacturerPath);
          properties.model = _getText(mainDocument, _kModelPath);
        } catch (e) {
          logger.warning('Unable to fetch device documents');
        }
      }

      device.locationData = locationData;
      device.properties = properties;

      logger.information(
        'Discovered device',
        {
          'friendlyName': properties.friendlyName,
          'model': properties.model,
          'manufacturer': properties.manufacturer,
        },
      );

      controller.add(device);
    }, onDone: () => controller.close(), onError: (err) => controller.addError(err));
  }

  _getText(XmlDocument doc, List<String> path) {
    try {
      var element = doc.getElement(path[0]);

      for (int i = 1; i < path.length; ++i) {
        element = element.getElement(path[i]);
      }

      return element.innerText;
    } catch (e) {
      logger.warning('Unable to get path ${path.join('.')}');
    }
  }

  Future<List<DeviceDocument>> _getDocuments(Uri uri) async {
    final raw = await data.download(uri.toString());

    if (raw != null) {
      final name = uri.path.split('/').last.replaceAll('.xml', '');
      final xmlDocument = XmlDocument.parse(raw);
      var docs = [
        DeviceDocument(
          xmlDocument,
          name,
        )
      ];

      final otherUris = _findOtherDocs(xmlDocument.rootElement, uri.origin);

      if (otherUris.isNotEmpty) {
        for (var i = 0; i < otherUris.length; ++i) {
          final childDocs = await _getDocuments(otherUris[i]);
          docs.addAll(childDocs);
        }
      }

      return docs;
    }

    return [];
  }

  List<Uri> _findOtherDocs(XmlNode node, String origin) {
    if (node is XmlText) {
      final text = node.text.trim();

      if (text.endsWith('.xml')) {
        final uri = Uri.tryParse('$origin$text');

        if (uri != null) {
          return [uri];
        }
      }

      return [];
    } else {
      var links = <Uri>[];

      node.children.forEach(
        (n) => links.addAll(
          _findOtherDocs(n, origin),
        ),
      );

      return links;
    }
  }

  Stream<Device> get stream => controller.stream;

  Stream<Device> findDevices() {
    if (!discovery.isInitialized) {
      discovery.init().then((_) => discovery.search());
    } else {
      discovery.search();
    }

    return stream;
  }
}
