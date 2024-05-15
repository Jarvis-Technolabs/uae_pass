///API timeout times
const int API_CONNECT_TIMEOUT = 30000;
const int SIGNAL_R_SOCKET_CONNECT_TIMEOUT = 30000;
const int RECEIVE_TIMEOUT = 60000;
const int SEND_TIMEOUT = 60000;

///Error code
const int LOCAL_ERROR_CODE = 0;
const int UN_AUTHORISED_ERROR_CODE = 401;

///String exception
const String SOCKET_EXCEPTION = "SocketException";

///Header key and values
const String CONTENT_TYPE = "content-Type";
const String ACCEPT = "Accept";
const String APPLICATION_JSON_CONTENT_TYPE = 'application/json';
const String APPLICATION_X_WWW_URL_FORM_URL_ENCODED_CONTENT_TYPE =
    "application/x-www-form-urlencoded; charset=UTF-8";

///=========================================================================///

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
