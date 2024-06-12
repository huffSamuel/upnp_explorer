import 'package:upnped/upnped.dart';

class PropertyFilter<T> {
  final Iterable<T> _allowedValues;
  final T Function(NetworkEvent event) accessor;

  PropertyFilter({
    required this.accessor,
    Iterable<T> allowedValues = const [],
  }) : _allowedValues = allowedValues;

  bool isEnabled(T value) => _allowedValues.contains(value);

  bool isSatisfied(NetworkEvent event) {
    if (_allowedValues.length == 0) {
      return true;
    }

    final value = accessor(event);

    return _allowedValues.any((x) => x == value);
  }

  PropertyFilter<T> _copyWith(Iterable<T> allowedValues) => PropertyFilter<T>(
        accessor: accessor,
        allowedValues: allowedValues,
      );
  PropertyFilter<T> addValue(T value) => _copyWith([..._allowedValues, value]);
  PropertyFilter<T> removeValue(T value) => _copyWith(
        _allowedValues.where((x) => x != value),
      );
  PropertyFilter<T> clear() => _copyWith([]);
}
