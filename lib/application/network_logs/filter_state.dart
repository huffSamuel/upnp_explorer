import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../packages/upnp/upnp.dart';
import '../../presentation/core/widgets/model_binding.dart';

class Filter<T> {
  final bool Function(T) predicate;
  final String label;
  final String id;
  final String? group;

  Filter(
    this.predicate,
    this.label, {
    String? id,
    this.group,
  }) : id = id ?? label;
}

class FilterState extends Equatable {
  final List<Filter<NetworkMessage>> filters;

  const FilterState({
    required this.filters,
  });

  Iterable<NetworkMessage> filter(Iterable<NetworkMessage> messages) {
    if (filters.length == 0) {
      return messages;
    }

    final allowed = <NetworkMessage>[];

    for (final msg in messages) {
      for (final filter in filters) {
        if (filter.predicate(msg)) {
          allowed.add(msg);
          break;
        }
      }
    }

    return allowed;
  }

  @override
  List<Object?> get props => [
        ...filters,
      ];

  static FilterState of(BuildContext context) =>
      ModelBinding.of<FilterState>(context);

  static void update(BuildContext context, FilterState newModel) =>
      ModelBinding.update(context, newModel);
}
