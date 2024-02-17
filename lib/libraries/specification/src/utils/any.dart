part of specification_pattern;

CompositeSpecification<T> any<T>(List<CompositeSpecification<T>> specs) {
  if (specs.isEmpty) {
    return CallbackSpecification(callback: (_) => true);
  }

  if (specs.length == 1) {
    return specs[0];
  }

  return specs.skip(1).fold(
        specs.first,
        (previousValue, element) => previousValue.or(element),
      );
}
