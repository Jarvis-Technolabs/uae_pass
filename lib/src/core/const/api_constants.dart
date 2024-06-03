///API timeout times
const int kApiConnectTimeout = 30000;

///Error code
const int kLocalErrorCode = 0;
const int kUnAuthorisedErrorCode = 401;

///String exception
const String kSocketException = "SocketException";

///Header key and values
const String kContentType = "content-type";
const String kApplicationXWwwFromUrlEncodedContentType =
    "application/x-www-form-urlencoded";

///=========================================================================///

/// UAE Pass web api

const String kUaePassAuthenticationUrl = "idshub/authorize";
const String kUaePassTokenUrl = "idshub/token";
const String kUaePassProfileUrl = "idshub/userinfo";

/// UAE Pass web api parameters

const String kResponseType = "code";
const String kScope = "urn:uae:digitalid:profile:general";
const String kUaePassMobileAuthenticationFlow =
    "urn:digitalid:authentication:flow:mobileondevice";
const String kUaePassWebAuthenticationFlow =
    "urn:safelayer:tws:policies:authentication:level:low";
const String kDigitalIdUrlApp = "uaepass://digitalid";
const String kKeySuccessUrl = "successurl";
const String kKeyFailureUrl = "failureurl";
const String kKeyCloseOnDone = "closeondone";
const String kKeyCloseOnDoneFalseValue = "&$kKeyCloseOnDone=false";
const String kKeyBrowserPackage = "browserpackage";

const String kKeyCode = "code";
const String kKeyState = "state";

const String kKeyError = "error";
const String kKeyAccessDenied = "access_denied";
const String kKeyLoadSuccessUrl = "loadSuccessUrl";
const String kKeyFinished = "finished";
const String kKeyCancelled = "canceled";
const String kKeyFailed = "failed";
const String kKeyAccessToken = "access_token";
const String kUserTypeSop1 = "SOP1";
const String kKeyBasicAuthToken = "Basic ";
const String kKeyAuthorization = "Authorization";
const String kKeyContentType = "Content-Type";
const String kKeyAuthorizationCode = "authorization_code";
const String kKeyClientId = "client_id";
const String kKeyClientSecret = "client_secret";
const String kUaePassAndroidBundleId = "uaepass://";
const String kUaePassAndroidStagingBundleId = "uaepassstg://";

/// web api error type
const int kOkResultCode = 200;
const int kSop1UserTypeErrorCode = -1;
const int kUserCancelledCode = -2;
