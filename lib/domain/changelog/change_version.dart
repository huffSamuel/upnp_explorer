class ChangeVersion {
  final String version;
  final List<String> changes;

  ChangeVersion(this.version, this.changes);

  ChangeVersion.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        changes = List<String>.from(json['changes']);
}
