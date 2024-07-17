import 'package:logger/logger.dart';

class Print {
  Print(object) {
    _logger.i(object);
  }

  static final _logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  static inf(object) {
    _logger.i(object);
  }

  static err(e, [s]) {
    _logger.e(e);
    if (s != null) {
      _logger.e(s);
    }
  }

  static war(object) {
    _logger.w(object);
  }

  static debug(object) {
    _logger.d(object);
  }

  static ver(object) {
    _logger.v(object);
  }

  static wtf(object) {
    _logger.wtf(object);
  }
}
