import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';

const bool ENABLE_STORING_LOGS_TO_FILE = false;
const String ANDROID_DOWNLOAD_PATH = "storage/emulated/0/Download/";
const String LOG_FILE_NAME = "UAE_Pass_Logs.txt";

/// uae pass app details
const String UAE_PASS_IOS_APP_STORE_ID = "1377158818";
const String UAE_PASS_IOS_APP_LINK =
    "itms-appss://apps.apple.com/ae/app/uae-pass/id$UAE_PASS_IOS_APP_STORE_ID";
String UAE_PASS_ANDROID_APP_LINK =
    "https://play.google.com/store/apps/details?id=${FlavourConfig.instance.androidPackageId}";

/// Font
const String FONT_FAMILY_GE_FLOW = 'GEFlow';

/// Language
const String EN = 'en';
const String AR = 'ar';

///UAE Pass platform call
const String METHOD_CHANNEL_NAME = "uaepass";
const String OPEN_UAE_PASS_APP = "openUaePassApp";
const String URL = "url";
