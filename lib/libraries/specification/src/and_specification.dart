part of specification_pattern;

class AndSpecification<T> extends CompositeSpecification<T> {
  final CompositeSpecification<T> left;
  final CompositeSpecification<T> right;

  AndSpecification(this.left, this.right);

  @override
  bool isSatisfied(T event) {
    return left.isSatisfied(event) && right.isSatisfied(event);
  }
}
