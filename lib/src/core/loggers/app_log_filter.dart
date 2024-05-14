import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => kReleaseMode;
}
