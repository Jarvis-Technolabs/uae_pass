import 'dart:developer';
import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_custom_utility/flutter_custom_utility.dart';
import 'package:ft_uaepass/src/core/di/injection_container.dart';
import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';
import 'package:logger/logger.dart';

Logger? logger = sl();

class CommonUtilities extends Utilities {
  ///Print Full Log
  void printFullLog(String text) {
    if (kDebugMode) {
      log(text);
    } else {
      Logger logger = sl();
      logger.t(text);
    }
  }

  Future<bool> isUaePassAppAvailable() async {
    if (Platform.isAndroid) {
      return await AppCheck.isAppInstalled(
              FlavourConfig.instance.androidPackageId) &&
          await AppCheck.isAppEnabled(FlavourConfig.instance.androidPackageId);
    } else {
      return await AppCheck.isAppInstalled(
          FlavourConfig.instance.iosBundleSchema);
    }
  }

  String? getQueryParameterValue(String queryParameter, Uri uri) =>
      uri.queryParameters[queryParameter];
}
