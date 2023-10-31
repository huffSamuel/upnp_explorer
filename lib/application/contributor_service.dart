import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../packages/github/contributor.dart';
import 'application.dart';

@lazySingleton
class ContributorsService {
  final _subject = BehaviorSubject<Iterable<Contributor>>.seeded([]);

  Stream<Iterable<Contributor>> get contributors$ => _subject.stream;

  load() {
    rootBundle
        .loadString(Application.assets.contributors)
        .asStream()
        .map((s) => jsonDecode(s) as List<dynamic>)
        .map(
          (s) => s.map((x) => Contributor.fromJson(x as Map<String, dynamic>)),
        )
        .take(1)
        .listen(_subject.add);
  }
}
