import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:uae_pass/src/core/flavour/flavour_config.dart';
import 'package:uae_pass/src/core/localizations/app_localizations.dart';
import 'package:uae_pass/src/core/util/common_utilities.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/UAEPassWebViewResultModel.dart';

import '../../../core/const/UAEPassApiConstant.dart';
import 'bloc/uae_pass_web_view_bloc.dart';
import 'bloc/uae_pass_web_view_state.dart';
import 'bloc/uaee_pass_web_view_event.dart';

class UAEPassWebViewScreen extends StatefulWidget {
  const UAEPassWebViewScreen({super.key});

  @override
  UAEPassWebViewScreenState createState() => UAEPassWebViewScreenState();
}

class UAEPassWebViewScreenState extends State<UAEPassWebViewScreen> {
  late InAppWebViewController webView;

  late bool isDarkTheme, isEnglish;

  StreamController<bool> showLoadingStreamController =
      StreamController<bool>.broadcast();

  String redirectUrl = "";
  String? successUrl = "";
  String? failureUrl = "";
  var currentStateForUAEPassLogin = "";
  final EncryptionRepo? encryptionRepo = sl();

  @override
  void initState() {
    super.initState();
    createUrl();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: onClickBack,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            systemOverlayStyle: getBrightness(),
            elevation: 0.0,
            backgroundColor: appColors.changedPensionerBackgroundColor,
            leading: BackIcon(
              screenUtil: screenUtil,
              iconColor: appColors.backIconBrownColor,
              onBackCalled: () async {
                if (await webView.canGoBack()) {
                  await webView.goBack();
                } else {
                  onClickBack();
                }
              },
            ),
            title: Container(
              child: getAppbarLogoPath().getImage(
                screenUtil: screenUtil!,
                height: 60.0,
                width: 180.0,
              ),
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<UAEPassWebViewBloc, UAEPassWebViewState>(
                  listener: (context, state) async {
                if (state is SetUAEPassLoginAuthenticationUrlState) {
                  // set authentication url to redirect url for UAE Pass login
                  redirectUrl = state.authenticationUrl;
                } else if (state is FetchUAEPassProfileState) {
                  // UAE Pass login -> fetch uae pass profile data

                  await webView.clearCache();
                  UAEPassWebViewResultModel model = UAEPassWebViewResultModel(
                      status: (state.uaeDataModel.userType != USER_TYPE_SOP1),
                      message: "",
                      uaeDataModel: state.uaeDataModel);
                  goBack(context, result: model);
                } else if (state is ErrorState) {
                  // Error

                  await webView.clearCache();
                  String? errorMessage = state.error;
                  if (state.apiStatus == PROFILE_ERROR) {
                    errorMessage = AppLocalizations.of(context)!
                        .translate(UNAUTHORISED_ERROR);
                  }
                  UAEPassWebViewResultModel model = UAEPassWebViewResultModel(
                    status: false,
                    message: errorMessage,
                    errorType: state.apiStatus,
                    uaeDataModel: state.uaeDataModel,
                  );
                  goBack(context, result: model);
                }
              })
            ],
            child: BlocBuilder<UAEPassWebViewBloc, UAEPassWebViewState>(
                builder: (context, state) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          if (redirectUrl.isNotEmpty) ...[getWebView()],
                          Center(
                            child: StreamBuilder<bool>(
                              initialData: true,
                              stream: showLoadingStreamController.stream,
                              builder: (context, snapshot) => snapshot.data!
                                  ? getCircularProgressIndicator(appColors)
                                  : SizedBox.shrink(),
                            ),
                          )
                        ],
                      ),
                    )),
          ),
        ),
      );

  createUrl() async {
    // Check UAE Pass app installed or not in android or ios
    bool isMobileApp = await CommonUtilities.isUaePassAppAvailable();

    currentStateForUAEPassLogin =
        encryptionRepo!.generateRandomKey(specialCharNeeded: false);

    // Fetch Profile url based on UAE pass app installed or not
    // set authentication url to redirect url for UAE Pass login
    BlocProvider.of<UAEPassWebViewBloc>(context).add(
      SetUAEPassLoginAuthenticationUrlEvent(
        authenticationUrl: getFetchProfileUrl(
          isMobileApp,
          currentStateForUAEPassLogin,
          FlavourConfig.instance!.apiBaseUrl,
          FlavourConfig.instance!.redirectUrl,
          FlavourConfig.instance!.clientId,
        ),
      ),
    );
  }

  Future<bool> onClickBack() async {
    UAEPassWebViewResultModel model = UAEPassWebViewResultModel(
        status: false,
        errorType: USER_CANCELLED,
        message: AppLocalizations.of(context)!.translate(LABEL_USER_CANCEL));
    await webView.clearCache();
    Navigator.of(context).pop(model);
    return false;
  }

  Widget getWebView() => InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            useOnLoadResource: true,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
        ),
        initialUrlRequest: URLRequest(
          url: Uri.parse(redirectUrl),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, Uri? url) {
          showLoadingStreamController.add(false);
        },
        onLoadStop: (InAppWebViewController controller, Uri? url) async {},
        onCreateWindow:
            (controller, CreateWindowAction createWindowAction) async {
          await webView.loadUrl(urlRequest: createWindowAction.request);
          return false;
        },
        shouldOverrideUrlLoading: (InAppWebViewController controller,
            NavigationAction navigationAction) async {
          String url = navigationAction.request.url.toString();

          // check if url define to redirect in uae pass app or web otherwise send in else part
          if (url.contains(DIGITAL_ID_URL_APP)) {
            // check if uae pass production app and in android
            if (!FlavourConfig.isProd()) {
              // replace android schema with android staging schema for uae pass app
              url = url.replaceAll(UAE_PASS_ANDROID_PROD_BUNDLE_ID,
                  UAE_PASS_ANDROID_STAGING_BUNDLE_ID);
            }

            // get successurl or failureurl for loading when authorization is successfully
            successUrl =
                getQueryParameterValue(KEY_SUCCESS_URL, Uri.parse(url));
            failureUrl =
                getQueryParameterValue(KEY_FAILURE_URL, Uri.parse(url));

            // url to pass in uae pass app for authorization
            Uri callBackUri = Uri.parse(url);
            String latestUrl = "";
            Map<String, String?> queryParameter = {};
            queryParameter.addAll(callBackUri.queryParameters);

            // change some parameter based on platform android and ios
            if (Platform.isAndroid) {
              queryParameter.update(
                KEY_SUCCESS_URL,
                (existingValue) => FlavourConfig.instance!.redirectUrl,
                ifAbsent: () => FlavourConfig.instance!.redirectUrl,
              );

              queryParameter.update(
                KEY_FAILURE_URL,
                (existingValue) => FlavourConfig.instance!.redirectUrl,
                ifAbsent: () => FlavourConfig.instance!.redirectUrl,
              );

              callBackUri =
                  callBackUri.replace(queryParameters: queryParameter);
              latestUrl =
                  callBackUri.toString() + KEY_CLOSE_ON_DONE_FALSE_VALUE;
            } else {
              queryParameter.remove(KEY_CLOSE_ON_DONE);
              queryParameter.remove(KEY_BROWSER_PACKAGE);
              callBackUri =
                  callBackUri.replace(queryParameters: queryParameter);
              latestUrl = callBackUri.toString();
            }

            var intent = await AppAvailability.launchApp(latestUrl);

            // check if uae pass app returning with valid success data
            if (intent != null && intent == KEY_LOAD_SUCCESS_URL) {
              webView.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(successUrl!),
                ),
              );
              return NavigationActionPolicy.CANCEL;
            } else if (intent != null && intent == KEY_CANCELLED) {
              BlocProvider.of<UAEPassWebViewBloc>(context).add(ErrorEvent(
                  AppLocalizations.of(context).translate(LABEL_USER_CANCEL),
                  USER_CANCELLED));
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          } else if ((Platform.isIOS && url.contains(UAE_PASS_IOS_APP_LINK)) ||
              (Platform.isAndroid && url.contains(UAE_PASS_ANDROID_APP_LINK))) {
            StoreRedirect.redirect(
              androidAppId: PROD_UAE_PASS_ANDROID_PACKAGE_ID,
              iOSAppId: UAE_PASS_IOS_APP_STORE_ID,
            );
            if (Platform.isAndroid) {
              return NavigationActionPolicy.CANCEL;
            } else {
              return NavigationActionPolicy.ALLOW;
            }
          } else if (url.startsWith(FlavourConfig.instance!.cancelledUrl)) {
            BlocProvider.of<UAEPassWebViewBloc>(context).add(ErrorEvent(
                AppLocalizations.of(context)!.translate(LABEL_USER_CANCEL),
                USER_CANCELLED));
            return NavigationActionPolicy.ALLOW;
          } else {
            // check if url start with redirect url
            if (url.startsWith(FlavourConfig.instance!.redirectUrl)) {
              // get access code and current state
              String? code = getQueryParameterValue(KEY_CODE, Uri.parse(url));
              String? currentState =
                  getQueryParameterValue(KEY_STATE, Uri.parse(url));
              String? error = getQueryParameterValue(KEY_ERROR, Uri.parse(url));

              // check any error exist
              if (error != null) {
                // check type of error and close with error
                if (error.contains(KEY_ACCESS_DENIED)) {
                  BlocProvider.of<UAEPassWebViewBloc>(context).add(ErrorEvent(
                      AppLocalizations.of(context)!
                          .translate(LABEL_USER_CANCEL),
                      USER_CANCELLED));
                } else {
                  BlocProvider.of<UAEPassWebViewBloc>(context).add(ErrorEvent(
                      AppLocalizations.of(context)!
                          .translate(LABEL_USER_CANCEL),
                      USER_CANCELLED));
                }
                return NavigationActionPolicy.ALLOW;
              }

              // check if url return exact state that we pass in fetchprofileurl
              if (currentStateForUAEPassLogin != currentState) {
                code = null;
              }
              // check if code is valid or not
              if (code != null) {
                // use access code for finding uae pass profile data from access code
                BlocProvider.of<UAEPassWebViewBloc>(context)
                    .add(FetchUAEPassProfileEvent(accessToken: code));
              }
              return NavigationActionPolicy.CANCEL;
            } else {
              return NavigationActionPolicy.ALLOW;
            }
          }
        },
      );

  @override
  void dispose() {
    super.dispose();
    showLoadingStreamController.close();
  }

  SystemUiOverlayStyle getBrightness() =>
      isDarkTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;

  String getAppbarLogoPath() => isDarkTheme
      ? isEnglish
          ? AD_PENSION_WHITE_LOGO
          : ADPF_DARK_AR_LOGO_ICON
      : isEnglish
          ? ADPF_LOGO_ICON
          : ADPF_AR_LOGO_ICON;
}
