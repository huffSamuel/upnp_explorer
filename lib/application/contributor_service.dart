import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../packages/github/contributor.dart';
import 'application.dart';

@lazySingleton
class ContributorsService {
  var _loaded = false;

  final _subject = BehaviorSubject<Iterable<Contributor>>.seeded([]);

  /// Stream of users who contributed to this project.
  Stream<Iterable<Contributor>> get contributors$ => _subject.stream;

  /// Load users who contributed to this project.
  ///
  /// The contributor list is pulled from assets, not live from github.
  void load() {
    if (_loaded) {
      return;
    }

    rootBundle
        .loadString(Application.assets.contributors)
        .asStream()
        .map((s) => jsonDecode(s) as List<dynamic>)
        .map(
          (s) => s.map((x) => Contributor.fromJson(x as Map<String, dynamic>)),
        )
        .take(1)
        .listen(_onLoad);
  }

  _onLoad(Iterable<Contributor> contributors) {
    _subject.add(contributors);
    _loaded = true;
  }
}
