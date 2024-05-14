import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter_custom_utility/flutter_custom_utility.dart';
import 'package:logger/logger.dart';
import 'package:uae_pass/src/core/di/injection_container.dart';
import 'package:uae_pass/src/core/flavour/flavour_config.dart';

Logger? logger = sl();

class CommonUtilities extends Utilities {
  ///Print Full Log
  void printFullLog(String text) {
    Logger logger = sl();
    int length = text.length;
    for (int i = 0; i < length; i += 1024) {
      if (i + 1024 < length) {
        logger.log(Level.verbose, text.substring(i, i + 1024));
      } else {
        logger.log(Level.verbose, text.substring(i, length));
      }
    }
  }

  static Future<bool> isUaePassAppAvailable() async {
    if (Platform.isAndroid) {
      return await AppCheck.isAppInstalled(
              FlavourConfig.instance!.androidPackageId) &&
          await AppCheck.isAppEnabled(FlavourConfig.instance!.androidPackageId);
    } else {
      return await AppCheck.isAppInstalled(
          FlavourConfig.instance!.iosBundleSchema);
    }
  }
}
