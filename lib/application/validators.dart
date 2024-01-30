final _uuid =
    RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$');
final _base64 = RegExp(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');
RegExp _hexadecimal = RegExp(r'^[0-9a-fA-F]+$');

String? _isNotEmpty(String? s) => s == null || s.isEmpty ? '*' : null;

String? _isChar(String? s) => s == null || s.length != 1 ? '*' : null;

String? _isURI(String? s) => s == null || Uri.tryParse(s) == null ? '*' : null;

String? _isDateTime(String? s) =>
    s == null || DateTime.tryParse(s) == null ? '*' : null;

String? _test(String? s, RegExp regex) =>
    s == null || regex.hasMatch(s) ? '*' : null;

String? _isBoolean(String? s) =>
    s == null || !['true', 'false'].contains(s) ? '*' : null;

class Validators {
  static String? isNotEmpty(String? s) => _isNotEmpty(s);
  static String? isUUID(String? s) => _test(s, _uuid);
  static String? isBase64(String? s) => _test(s, _base64);
  static String? isChar(String? s) => _isChar(s);
  static String? isHexadecimal(String? s) => _test(s, _hexadecimal);
  static String? isURI(String? s) => _isURI(s);
  static String? isDateTime(String? s) => _isDateTime(s);
  static String? isBoolean(String? s) => _isBoolean(s);
}
