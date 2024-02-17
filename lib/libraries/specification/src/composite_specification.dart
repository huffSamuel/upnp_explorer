part of specification_pattern;

abstract class CompositeSpecification<T> {
  bool isSatisfied(T event) {
    throw UnimplementedError();
  }

  CompositeSpecification<T> and(CompositeSpecification<T> other) {
    return AndSpecification(this, other);
  }

  CompositeSpecification<T> or(CompositeSpecification<T> other) {
    return OrSpecification(this, other);
  }
}
