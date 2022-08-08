class _Props {
  final String name;
  final String version;

  _Props(this.name, this.version);
  _Props.from(List<String> props) : this(props[0], props[1]);
}

class UpnpServer {
  /// Information regarding the operating system.
  final _Props os;

  /// Information regarding the supported UPnP protocol.
  final _Props upnp;

  /// Information regarding the product.
  final _Props product;

  UpnpServer(this.os, this.upnp, this.product);

  factory UpnpServer.parse(String str) {
    final fields = str.split(',');

    return UpnpServer(
      _Props.from(fields[0].split('/')),
      _Props.from(fields[1].split('/')),
      _Props.from(fields[2].split('/')),
    );
  }
}
