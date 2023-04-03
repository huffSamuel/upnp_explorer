import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:injectable/injectable.dart';

import 'settings/options.dart';

@Singleton()
class LoggerFactory {
  Logger build(String className) {
    return Logger(className, this);
  }
}

enum LogLevel {
  fatal,
  error,
  warn,
  info,
  debug,
}

class Logger {
  /// The [LoggerFactory] that build this logger.
  ///
  /// Helpful for passing factories down to child objects without
  /// dependency injection all the way down.
  final LoggerFactory factory;

  /// A context that is printed with each log.
  final context = {};
  final className;

  Logger(this.className, this.factory);

  /// Log a FATAL message.
  ///
  /// The most critical level.
  void fatal(
    String message, [
    Map<String, dynamic> scopedContext = const {},
  ]) =>
      _write(LogLevel.fatal, message, scopedContext);

  /// Log an ERROR message.
  ///
  /// When functionality is unavailable or expectations broken.
  void error(
    String message, [
    Map<String, dynamic> scopedContext = const {},
  ]) =>
      _write(LogLevel.error, message, scopedContext);

  /// Log a WARN message.
  ///
  /// When service is degraded, endangered, or may be behaving outside of its
  /// expected parameters.
  void warning(
    String message, [
    Map<String, dynamic> scopedContext = const {},
  ]) =>
      _write(LogLevel.warn, message, scopedContext);

  /// Log an INFO message.
  ///
  /// Describe things happening in the system that correspond to its
  /// responsibilities and functions. Generally these are the observable actions
  /// a system can perform.
  void information(
    String message, [
    Map<String, dynamic> scopedContext = const {},
  ]) =>
      _write(LogLevel.info, message, scopedContext);

  /// Log a DEBUG message.
  ///
  /// Used for internal system events that are not necessarily observable from
  /// the outside but are useful when determining how something happened.
  void debug(
    String message, [
    Map<String, dynamic> scopedContext = const {},
  ]) =>
      _write(LogLevel.debug, message, scopedContext);

  void _write(
    LogLevel level,
    String message,
    Map<String, dynamic> scopedContext,
  ) {
    final timestamp = DateTime.now();

    final sb = StringBuffer()
      ..write(timestamp.toUtc())
      ..write(' | ')
      ..write(level.name)
      ..write(' | ')
      ..write(className)
      ..write(' | ')
      ..write(message);

    if (context.isNotEmpty) {
      sb.write(' | ');
      try {
        final encoded = jsonEncode(context);
        sb.write(encoded);
      } catch (err) {
        sb.write('Failed to encode logging context. Stringifying. ');

        for (final i in context.entries) {
          sb
            ..write(i.key.toString())
            ..write(' : ')
            ..write(i.value.toString())
            ..write(' ');
        }
      }
    }

    if (scopedContext.isNotEmpty) {
      sb.write(' | ');
      try {
        final encoded = jsonEncode(scopedContext);
        sb.write(encoded);
      } catch (err) {
        sb.write('Failed to encode context. Stringifying. ');

        for (final i in scopedContext.entries) {
          sb
            ..write(i.key.toString())
            ..write(' : ')
            ..write(i.value.toString())
            ..write(' ');
        }
      }
    }

    if (Foundation.kDebugMode) {
      print(sb);
    }
  }
}
