import '../../simple_upnp/src/upnp.dart';

abstract class CompositeSpecification {
  bool enabled;

  CompositeSpecification({this.enabled = true});

  bool isSatisfiedBy(UPnPEvent event) {
    if (!enabled) {
      return false;
    }

    return satisfiedBy(event);
  }

  bool satisfiedBy(UPnPEvent event);

  CompositeSpecification and(CompositeSpecification other) {
    return AndSpecification(this, other);
  }

  CompositeSpecification or(CompositeSpecification other) {
    return OrSpecification(this, other);
  }

  static any(List<CompositeSpecification> specs) {
    if (specs.isEmpty) {
      return ImmediateSpecification((event) => true);
    }

    if (specs.length == 1) {
      return specs[0];
    }

    return specs.reduce((a, b) => a.or(b));
  }

  static all(List<CompositeSpecification> specs) {
    if (specs.isEmpty) {
      return ImmediateSpecification((event) => true);
    }

    if (specs.length == 1) {
      return specs[0];
    }

    return specs.reduce((a, b) => a.and(b));
  }
}

class ImmediateSpecification extends CompositeSpecification {
  final bool Function(UPnPEvent event) predicate;
  final String? identifier;

  ImmediateSpecification(
    this.predicate, {
    this.identifier,
    bool enabled = false,
  }) {
    this.enabled = enabled;
  }

  @override
  bool satisfiedBy(UPnPEvent event) {
    return predicate(event);
  }
}

class AndSpecification extends CompositeSpecification {
  final CompositeSpecification left;
  final CompositeSpecification right;

  AndSpecification(this.left, this.right);

  @override
  bool satisfiedBy(UPnPEvent event) {
    return left.satisfiedBy(event) && right.satisfiedBy(event);
  }
}

class OrSpecification extends CompositeSpecification {
  final CompositeSpecification left;
  final CompositeSpecification right;

  OrSpecification(this.left, this.right);

  @override
  bool satisfiedBy(UPnPEvent event) {
    return left.satisfiedBy(event) || right.satisfiedBy(event);
  }
}
