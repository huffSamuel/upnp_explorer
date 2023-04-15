part of wol;

class MacAddress {
  final _is48BitMac =
      RegExp('^[0-9A-Fa-f]{2}([:-]?)(?:[0-9A-Fa-f]{2}\1){4}[0-9A-Fa-f]{2}\$');

  final String address;

  MacAddress._(this.address);

  List<int> get bytes =>
      address.split(':').map((x) => hex.decode(x)[0]).toList();

  /// Attempts to parse [address] as MAC address.
  ///
  /// Returns `null` if[address] is not a numeric 48-bit (semicolon-separated) address.
  MacAddress? tryParse(String address) {
    if (!_is48BitMac.hasMatch(address)) {
      return null;
    }

    return MacAddress._(address);
  }
}
