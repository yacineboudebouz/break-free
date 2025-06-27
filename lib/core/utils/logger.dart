import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

/// Application-wide logger utility
/// Provides configured logger instances for different parts of the app
class AppLogger {
  static Logger? _instance;

  /// Get the singleton logger instance
  static Logger get instance {
    _instance ??= _createLogger();
    return _instance!;
  }

  /// Create a configured logger instance
  static Logger _createLogger() {
    return Logger(
      printer: PrettyPrinter(
        methodCount: kDebugMode ? 2 : 0,
        errorMethodCount: kDebugMode ? 8 : 3,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: kDebugMode ? Level.debug : Level.warning,
      output: kDebugMode ? ConsoleOutput() : null,
    );
  }

  /// Create a logger for a specific class or feature
  static Logger getLogger(String className) {
    return Logger(
      printer: PrettyPrinter(
        methodCount: kDebugMode ? 2 : 0,
        errorMethodCount: kDebugMode ? 8 : 3,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: kDebugMode ? Level.debug : Level.warning,
      output: _TaggedConsoleOutput(className),
    );
  }

  /// Log debug information
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log informational messages
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning messages
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error messages
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log fatal error messages
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.f(message, error: error, stackTrace: stackTrace);
  }
}

/// Custom output that adds class/feature tags to log messages
class _TaggedConsoleOutput extends LogOutput {
  final String tag;

  _TaggedConsoleOutput(this.tag);

  @override
  void output(OutputEvent event) {
    if (kDebugMode) {
      for (final line in event.lines) {
        print('[$tag] $line');
      }
    }
  }
}
