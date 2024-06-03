import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';

const bool kEnableStoringLogsToFile = false;
const String kAndroidDownloadPath = "storage/emulated/0/Download/";
const String kLogFileName = "UAE_Pass_Logs.txt";

/// uae pass app details
const String kUaePassIosAppStoreId = "1377158818";
const String kUaePassIosAppLink =
    "itms-appss://apps.apple.com/ae/app/uae-pass/id$kUaePassIosAppStoreId";
String kUaePassAndroidAppLink =
    "https://play.google.com/store/apps/details?id=${FlavourConfig.instance.androidPackageId}";

/// Font
const String kFontFamilyGeFlow = 'GEFlow';

/// Language
const String kEn = 'en';
const String kAr = 'ar';

///UAE Pass platform call
const String kMethodChannelName = "uaepass";
const String kOpenUaePassApp = "openUaePassApp";
const String kUrl = "url";
