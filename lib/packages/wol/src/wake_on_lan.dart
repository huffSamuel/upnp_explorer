part of wol;

class WakeOnLan {
  final MacAddress macAddress;
  final InternetAddress address;

  WakeOnLan(this.macAddress, this.address);

  _buildPacket() {
    const data = <int>[];

    for (int i = 0; i < 6; i++) {
      data.add(0xFF);
    }

    for (int i = 0; i < 16; i++) {
      data.addAll(macAddress.bytes);
    }
  }

  Future<void> wake() async {
    final socket = await RawDatagramSocket.bind(address.type, 0)
      ..broadcastEnabled = true;

    socket.send(_buildPacket(), address, 9);
    socket.close();
  }
}
