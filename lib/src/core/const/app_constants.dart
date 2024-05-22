import 'package:uae_pass/src/core/flavour/flavour_config.dart';

const bool ENABLE_STORING_LOGS_TO_FILE = false;
const String ANDROID_DOWNLOAD_PATH = "storage/emulated/0/Download/";
const String LOG_FILE_NAME = "UAE_Pass_Logs.txt";

// uae pass app details
const String UAE_PASS_IOS_APP_STORE_ID = "1377158818";
const String UAE_PASS_IOS_APP_LINK =
    "itms-appss://apps.apple.com/ae/app/uae-pass/id$UAE_PASS_IOS_APP_STORE_ID";
String UAE_PASS_ANDROID_APP_LINK =
    "https://play.google.com/store/apps/details?id=${FlavourConfig.instance.androidPackageId}";

// uae pass locations attribute
const String UAE_PASS_KIOSK_LOCATIONS = "https://selfcare.uaepass.ae/locations";
const String UAE_PASS_SP = "tel://800555";
const String UAE_PASS_SP_NAME = "800555";

/// Font
const String FONT_FAMILY_GE_FLOW = 'GEFlow';

/// Language
const String EN = 'en';
const String AR = 'ar';
