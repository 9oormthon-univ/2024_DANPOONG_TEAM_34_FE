import 'package:logger/logger.dart';

abstract class LogUtil {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  /// Info log
  static void info(dynamic message) {
    _logger.i(message);
  }

  /// Debug log
  static void debug(dynamic message) {
    _logger.d(message);
  }

  /// Error log
  static void error(dynamic message) {
    _logger.e(message);
  }
}
