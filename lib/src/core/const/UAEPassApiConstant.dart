// UAE Pass web api
const String UAE_PASS_AUTHENTICATION_URL = "idshub/authorize";
const String UAE_PASS_TOKEN_URL = "idshub/token";
const String UAE_PASS_PROFILE_URL = "idshub/userinfo";

// UAE Pass web api parameters
const String DOCUMENT_SIGNING_SCOPE =
    "urn:safelayer:eidas:sign:process:document";
const String RESPONSE_TYPE = "code";
const String SCOPE = "urn:uae:digitalid:profile:general";
const String ACR_VALUES_MOBILE =
    "urn:digitalid:authentication:flow:mobileondevice";
const String ACR_VALUES_WEB =
    "urn:safelayer:tws:policies:authentication:level:low";
const String DIGITAL_ID_URL_APP = "uaepass://digitalid";
const String KEY_SUCCESS_URL = "successurl";
const String KEY_FAILURE_URL = "failureurl";
const String KEY_CLOSE_ON_DONE = "closeondone";
const String KEY_CLOSE_ON_DONE_FALSE_VALUE = "&$KEY_CLOSE_ON_DONE=false";
const String KEY_BROWSER_PACKAGE = "browserpackage";
const String KEY_SCOPE = "scope";
const String KEY_GRANT_TYPE = "grant_type";
const String KEY_REDIRECT_URI = "redirect_uri";
const String KEY_CODE = "code";
const String KEY_STATE = "state";
const String KEY_STATUS = "status";
const String KEY_ERROR = "error";
const String KEY_ACCESS_DENIED = "access_denied";
const String KEY_LOAD_SUCCESS_URL = "loadSuccessUrl";
const String KEY_FINISHED = "finished";
const String KEY_CANCELLED = "canceled";
const String KEY_FAILED = "failed";
const String KEY_ACCESS_TOKEN = "access_token";
const String USER_TYPE_SOP1 = "SOP1";
const String KEY_BASIC_AUTH_TOKEN = "Basic ";
const String KEY_AUTHORIZATION = "Authorization";
const String KEY_CONTENT_TYPE = "Content-Type";
const String KEY_AUTHORIZATION_CODE = "authorization_code";
const String KEY_CLIENT_ID = "client_id";
const String KEY_CLIENT_SECRET = "client_secret";

// uae pass app details
const String PROD_UAE_PASS_ANDROID_PACKAGE_ID = "ae.uaepass.mainapp";
const String STAGING_UAE_PASS_ANDROID_PACKAGE_ID = "ae.uaepass.mainapp.stg";

const String UAE_PASS_ANDROID_PROD_BUNDLE_ID = "uaepass://";
const String UAE_PASS_ANDROID_STAGING_BUNDLE_ID = "uaepassstg://";
const String UAE_PASS_IOS_APP_LINK =
    "itms-appss://apps.apple.com/ae/app/uae-pass/id$UAE_PASS_IOS_APP_STORE_ID";
const String UAE_PASS_IOS_APP_STORE_ID = "1377158818";
const String UAE_PASS_ANDROID_APP_LINK =
    "https://play.google.com/store/apps/details?id=$PROD_UAE_PASS_ANDROID_PACKAGE_ID";

// uae pass locations attribute
const String UAE_PASS_KIOSK_LOCATIONS = "https://selfcare.uaepass.ae/locations";
const String UAE_PASS_SP = "tel://800555";
const String UAE_PASS_SP_NAME = "800555";

// web api error type
const int RESULT_OK = 200;
const int PROFILE_ERROR = -2;
const int PROFILE_ERROR_USER_TYPE_SOP1 = -3;
const int DOCUMENT_ERROR_USER_TYPE_SOP2 = -4;
const int USER_CANCELLED = -5;
const int UNIDENTIFIED_ERROR = -6;
const int DOCUMENT_SIGN_ERROR = -7;
const int DOCUMENT_DOWNLOAD_ERROR = -8;
const int LOGIN_ERROR = -9;

// Todo remove when uae pass integration complete
// const String UAE_PASS_LOGOUT_URL =
//     "authserver/digitalid-idp/logout?redirect_uri=" + REDIRECT_URL;

// url for fetching uae pass login
String getFetchProfileUrl(bool isMobileApp, String state, String baseUrl,
    String redirectUrl, String clientID) {
  String arcValues = isMobileApp ? ACR_VALUES_MOBILE : ACR_VALUES_WEB;
  return "$baseUrl$UAE_PASS_AUTHENTICATION_URL?redirect_uri=$redirectUrl&client_id=$clientID&$KEY_STATE=$state&response_type=$RESPONSE_TYPE&scope=$SCOPE&acr_values=$arcValues&ui_locales=en";
}
