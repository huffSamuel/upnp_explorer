part of specification_pattern;

class NotSpecification<T> extends CompositeSpecification<T> {
  final CompositeSpecification<T> inner;

  NotSpecification(this.inner);

  @override
  bool isSatisfied(T event) {
    return !inner.isSatisfied(event);
  }
}
