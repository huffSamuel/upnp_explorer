import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../../domain/device.dart';
import 'device_discovery_service.dart';

class SocketOptions {
  final InternetAddress address;
  final InternetAddress multicastAddress;
  SocketOptions(this.address, this.multicastAddress);
}

class SSDPService {
  final controller = StreamController<Device>.broadcast();

  final DeviceDiscoveryService discovery;
  final DeviceDataService data;

  SSDPService(this.discovery, this.data) {
    discovery.stream.listen((event) async {
      final device = Device(event);
      final properties = DeviceProperties();

      properties.locationData = event.parsed['location'];
      String locationData;

      try {
        locationData = await data.download(event.parsed['location']);
      } catch (e) {
        print(e);
      }

      if (locationData != null) {
        try {
          final uri = Uri.parse(event.parsed['location']);
          final documents = await _getDocuments(uri);

          device.documents.addAll(documents);

          try {
            properties.friendlyName = device.documents.first.xmlDocument
                .getElement('root')
                .getElement('device')
                .getElement('friendlyName')
                .innerText;
          } catch (e) {}

          try {
            if (properties.friendlyName == null ||
                properties.friendlyName.isEmpty) {
              properties.friendlyName = device.documents.first.xmlDocument
                  .getElement('root')
                  .getElement('device')
                  .getElement('x-friendly-name')
                  .innerText;
            }
          } catch (e) {}

          try {
            properties.imageUrl = device.documents.first.xmlDocument
                .getElement('root')
                .getElement('device')
                .getElement('iconList')
                .getElement('icon')
                .getElement('url')
                .innerText;
          } catch (e) {}
        } catch (e) {
          print(e);
        }
      }

      device.locationData = locationData;
      device.properties = properties;

      controller.add(device);
    });
  }

  Future<List<DeviceDocument>> _getDocuments(Uri uri) async {
    final raw = await data.download(uri.toString());

    if (raw != null) {
      final name = uri.path.split('/').last.replaceAll('.xml', '');
      final xmlDocument = XmlDocument.parse(raw);
      var docs = [DeviceDocument(xmlDocument, name)];

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

  Future findDevices() {
    if (!discovery.isInitialized) {
      return discovery.init().then((_) => discovery.search());
    } else {
      return discovery.search();
    }
  }
}

class DeviceDataService {
  Future<String> download(String url) async {
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    return response.body;
  }
}
