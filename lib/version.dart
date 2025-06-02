import 'package:built_version_annotation/built_version_annotation.dart';

part 'version.g.dart';

@BuiltVersion()
String get version => _$PackageVersion.split('+').first;