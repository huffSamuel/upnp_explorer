class ActionArgument {
  final String name;
  final String value;

  ActionArgument(
    this.name,
    this.value,
  );

  @override
  String toString() {
    return '$name:$value';
  }
}
