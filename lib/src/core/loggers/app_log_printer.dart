import 'package:logger/logger.dart';
import 'package:uae_pass/src/core/const/app_constants.dart';
import 'package:uae_pass/src/core/loggers/log_to_file.dart';

class AppLogPrinter extends LogPrinter {
  final LoggerFileUtil loggerFileUtil;

  AppLogPrinter({
    required this.loggerFileUtil,
  });

  @override
  List<String> log(LogEvent event) {
    if (ENABLE_STORING_LOGS_TO_FILE) {
      loggerFileUtil.saveLogs(event.message);
    }
    return [event.message];
  }
}
