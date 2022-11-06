String? _isNotEmpty(String? s) => s == null || s.isEmpty ? '*' : null;

class Validators {
  static String? isNotEmpty(String? s) => _isNotEmpty(s);
}