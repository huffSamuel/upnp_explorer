part of specification_pattern;

class CallbackSpecification<T> extends CompositeSpecification<T> {
  final bool Function(T obj) callback;

  CallbackSpecification({required this.callback});

  @override
  bool isSatisfied(T obj) {
    return callback(obj);
  }
}
