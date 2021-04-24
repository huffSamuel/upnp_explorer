import 'package:ssdp/domain/device_document.dart';

class DeviceDocumentTree {
  final DeviceDocument root;
  final List<DeviceDocument> children;

  List<DeviceDocument> get documents => [
        root,
        ...children,
      ];

  DeviceDocumentTree(
    this.root, {
    this.children = const [],
  });
}
