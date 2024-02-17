String replaceMany(String str, Map<String, dynamic> replace) {
  var r = str;

  replace.forEach((key, value) {
    r = r.replaceAll(key, value.toString());
  });

  return r;
}
