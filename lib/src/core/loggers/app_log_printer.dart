import 'package:ft_uaepass/src/core/const/app_constants.dart';
import 'package:ft_uaepass/src/core/loggers/log_to_file.dart';
import 'package:logger/logger.dart';

class AppLogPrinter extends LogPrinter {
  final LoggerFileUtil loggerFileUtil;

  AppLogPrinter({
    required this.loggerFileUtil,
  });

  @override
  List<String> log(LogEvent event) {
    if (kEnableStoringLogsToFile) {
      loggerFileUtil.saveLogs(event.message);
    }
    return [event.message];
  }
}
