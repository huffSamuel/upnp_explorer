bool isNullOrEmpty(String? str) {
  return str == null || str.trim().isEmpty;
}

bool isNotNullOrEmpty(String? str) {
  return str != null && str.trim().isNotEmpty;
}