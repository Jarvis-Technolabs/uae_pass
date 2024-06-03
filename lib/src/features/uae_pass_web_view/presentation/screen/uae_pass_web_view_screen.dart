import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ft_uaepass/src/core/const/api_constants.dart';
import 'package:ft_uaepass/src/core/const/app_constants.dart';
import 'package:ft_uaepass/src/core/const/string_constants.dart';
import 'package:ft_uaepass/src/core/flavour/flavour_config.dart';
import 'package:ft_uaepass/src/core/localizations/uae_pass_app_localizations.dart';
import 'package:ft_uaepass/src/core/util/common_utilities.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/app_bar_properties.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_pass_web_view_result_model.dart';
import 'package:ft_uaepass/uae_pass_platform_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:store_redirect/store_redirect.dart';

import '../bloc/uae_pass_web_view_bloc.dart';
import '../bloc/uae_pass_web_view_event.dart';
import '../bloc/uae_pass_web_view_state.dart';

/// Uae Pass web view screen with progress indicator and web view for sign in
class UAEPassWebViewScreen extends StatefulWidget {
  final bool isDarkMode;
  final PreferredSizeWidget? appBar;
  final AppBarProperties? appBarProperties;
  const UAEPassWebViewScreen({
    super.key,
    this.isDarkMode = false,
    this.appBar,
    this.appBarProperties,
  });

  @override
  UAEPassWebViewScreenState createState() => UAEPassWebViewScreenState();
}

class UAEPassWebViewScreenState extends State<UAEPassWebViewScreen> {
  InAppWebViewController? webView;

  StreamController<bool> showLoadingStreamController =
      StreamController<bool>.broadcast();

  StreamController<bool> routeStreamController =
      StreamController<bool>.broadcast();

  String redirectUrl = "";
  String? successUrl = "";
  String? failureUrl = "";
  String currentStateForUAEPassLogin = FlavourConfig.instance.state;

  @override
  void initState() {
    createUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<UAEPassWebViewBloc, UAEPassWebViewState>(
        listener: (context, state) async {
          if (state is SetUAEPassLoginAuthenticationUrlState) {
            /// set authentication url to redirect url for UAE Pass login
            redirectUrl = state.authenticationUrl;
          } else if (state is FetchUAEPassProfileState) {
            /// UAE Pass login -> fetch uae pass profile data

            await webView?.clearCache();
            UAEPassWebViewResultModel uAEPassWebViewResultModel =
                UAEPassWebViewResultModel(
              status: (state.uaeDataModel.userType != kUserTypeSop1),
              message: "",
              uaeDataModel: state.uaeDataModel,
            );
            goBack(context, result: uAEPassWebViewResultModel);
          } else if (state is ErrorState) {
            /// Error
            await webView?.clearCache();
            String? errorMessage = state.errorMessage;
            if (state.apiStatus == kSop1UserTypeErrorCode) {
              errorMessage = UaePassAppLocalizations.of(context)
                  .translate(kLabelYourAccountUnverified);
            }
            UAEPassWebViewResultModel uAEPassWebViewResultModel =
                UAEPassWebViewResultModel(
              status: false,
              message: errorMessage,
              statusCode: state.apiStatus,
              uaeDataModel: state.uaeDataModel,
            );
            goBack(context, result: uAEPassWebViewResultModel);
          }
        },
        builder: (context, state) => StreamBuilder<bool>(
          initialData: false,
          stream: routeStreamController.stream,
          builder: (context, snapshot) => PopScope(
            canPop: snapshot.data!,
            onPopInvoked: (bool didPop) async {
              if (webView != null && await webView!.canGoBack()) {
                await webView!.goBack();
              } else if (!didPop) {
                await onClickBack();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: widget.appBar ??
                  webViewAppbar(
                    actions: widget.appBarProperties?.actions,
                    automaticallyImplyLeading:
                        widget.appBarProperties?.automaticallyImplyLeading,
                    backgroundColor: widget.appBarProperties?.backgroundColor,
                    backIcon: widget.appBarProperties?.backIcon,
                    centerTitle: widget.appBarProperties?.centerTitle,
                    elevation: widget.appBarProperties?.elevation,
                    shadowColor: widget.appBarProperties?.shadowColor,
                    titleSpacing: widget.appBarProperties?.titleSpacing,
                    titleWidget: widget.appBarProperties?.titleWidget,
                  ),
              body: Stack(
                children: [
                  if (redirectUrl.isNotEmpty) ...[getWebView()],
                  StreamBuilder<bool>(
                    initialData: true,
                    stream: showLoadingStreamController.stream,
                    builder: (context, snapshot) => snapshot.data!
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> createUrl() async {
    /// Check UAE Pass app installed or not in android or ios
    bool isMobileApp = await CommonUtilities().isUaePassAppAvailable();

    /// Fetch Profile url based on UAE pass app installed or not
    /// set authentication url to redirect url for UAE Pass login
    BlocProvider.of<UAEPassWebViewBloc>(context).add(
      SetUAEPassLoginAuthenticationUrlEvent(
        authenticationUrl: createAuthUrl(
          isMobileApp: isMobileApp,
          state: currentStateForUAEPassLogin,
          baseUrl: FlavourConfig.instance.apiBaseUrl,
          redirectUrl: FlavourConfig.instance.redirectUrl,
          clientID: FlavourConfig.instance.clientId,
        ),
      ),
    );
  }

  String createAuthUrl({
    required bool isMobileApp,
    required String state,
    required String baseUrl,
    required String redirectUrl,
    required String clientID,
  }) =>
      "$baseUrl$kUaePassAuthenticationUrl?redirect_uri=$redirectUrl&client_id=$clientID&$kKeyState=$state&response_type=$kResponseType&scope=$kScope&acr_values=${isMobileApp ? kUaePassMobileAuthenticationFlow : kUaePassWebAuthenticationFlow}&ui_locales=en";

  Future<bool> onClickBack() async {
    UAEPassWebViewResultModel model = UAEPassWebViewResultModel(
        status: false,
        statusCode: kUserCancelledCode,
        message:
            UaePassAppLocalizations.of(context).translate(kLabelUserCancel));
    await webView?.clearCache();
    routeStreamController.add(true);
    Navigator.of(context).pop(model);
    return true;
  }

  Widget getWebView() => InAppWebView(
        initialSettings: InAppWebViewSettings(
          forceDark: widget.isDarkMode ? ForceDark.ON : ForceDark.OFF,
          useShouldOverrideUrlLoading: true,
          useOnLoadResource: true,
          useHybridComposition: true,
        ),
        initialUrlRequest: URLRequest(
          url: WebUri(redirectUrl),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStop: (InAppWebViewController controller, Uri? url) async {
          showLoadingStreamController.add(false);
        },
        onCreateWindow:
            (controller, CreateWindowAction createWindowAction) async {
          await webView?.loadUrl(urlRequest: createWindowAction.request);
          return false;
        },
        shouldOverrideUrlLoading: (InAppWebViewController controller,
            NavigationAction navigationAction) async {
          String url = navigationAction.request.url.toString();

          /// check if url define to redirect in uae pass app or web otherwise send in else part
          if (url.contains(kDigitalIdUrlApp)) {
            /// check if uae pass production app and in android
            if (!FlavourConfig.isProd()) {
              /// replace android schema with android staging schema for uae pass app
              url = url.replaceAll(
                  kUaePassAndroidBundleId, kUaePassAndroidStagingBundleId);
            }

            /// get success url or failure url for loading when authorization is successfully
            successUrl = CommonUtilities()
                .getQueryParameterValue(kKeySuccessUrl, WebUri(url));
            failureUrl = CommonUtilities()
                .getQueryParameterValue(kKeyFailureUrl, WebUri(url));

            /// url to pass in uae pass app for authorization
            Uri callBackUri = WebUri(url);
            String latestUrl = "";
            Map<String, String?> queryParameter = {};
            queryParameter.addAll(callBackUri.queryParameters);

            /// change some parameter based on platform android and ios
            if (Platform.isAndroid) {
              queryParameter.update(
                kKeySuccessUrl,
                (existingValue) => FlavourConfig.instance.redirectUrl,
                ifAbsent: () => FlavourConfig.instance.redirectUrl,
              );

              queryParameter.update(
                kKeyFailureUrl,
                (existingValue) => FlavourConfig.instance.redirectUrl,
                ifAbsent: () => FlavourConfig.instance.redirectUrl,
              );

              callBackUri =
                  callBackUri.replace(queryParameters: queryParameter);
              latestUrl = callBackUri.toString() + kKeyCloseOnDoneFalseValue;
            } else {
              queryParameter.remove(kKeyCloseOnDone);
              queryParameter.remove(kKeyBrowserPackage);
              callBackUri =
                  callBackUri.replace(queryParameters: queryParameter);
              latestUrl = callBackUri.toString();
            }

            var intent =
                await UaePassPlatform.instance.openUaePassApp(url: latestUrl);

            /// check if uae pass app returning with valid success data
            if (intent != null && intent == kKeyLoadSuccessUrl) {
              webView?.loadUrl(
                urlRequest: URLRequest(
                  url: WebUri(successUrl!),
                ),
              );
              return NavigationActionPolicy.CANCEL;
            } else if (intent != null && intent == kKeyCancelled) {
              BlocProvider.of<UAEPassWebViewBloc>(context).add(
                ErrorEvent(
                  UaePassAppLocalizations.of(context)
                      .translate(kLabelUserCancel),
                  kUserCancelledCode,
                ),
              );
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          } else if ((Platform.isIOS && url.contains(kUaePassIosAppLink)) ||
              (Platform.isAndroid && url.contains(kUaePassAndroidAppLink))) {
            StoreRedirect.redirect(
              androidAppId: FlavourConfig.instance.androidPackageId,
              iOSAppId: kUaePassIosAppStoreId,
            );
            if (Platform.isAndroid) {
              return NavigationActionPolicy.CANCEL;
            } else {
              return NavigationActionPolicy.ALLOW;
            }
          } else if (url.startsWith(FlavourConfig.instance.cancelledUrl)) {
            BlocProvider.of<UAEPassWebViewBloc>(context).add(
              ErrorEvent(
                UaePassAppLocalizations.of(context).translate(kLabelUserCancel),
                kUserCancelledCode,
              ),
            );
            return NavigationActionPolicy.ALLOW;
          } else {
            /// check if url start with redirect url
            if (url.startsWith(FlavourConfig.instance.redirectUrl)) {
              /// get access code and current state
              String? code = CommonUtilities()
                  .getQueryParameterValue(kKeyCode, WebUri(url));
              String? currentState = CommonUtilities()
                  .getQueryParameterValue(kKeyState, WebUri(url));
              String? error = CommonUtilities()
                  .getQueryParameterValue(kKeyError, WebUri(url));

              /// check any error exist
              if (error != null) {
                /// check type of error and close with error
                if (error.contains(kKeyAccessDenied)) {
                  BlocProvider.of<UAEPassWebViewBloc>(context).add(ErrorEvent(
                      UaePassAppLocalizations.of(context)
                          .translate(kLabelUserCancel),
                      kUserCancelledCode));
                } else {
                  BlocProvider.of<UAEPassWebViewBloc>(context).add(ErrorEvent(
                      UaePassAppLocalizations.of(context)
                          .translate(kLabelUserCancel),
                      kUserCancelledCode));
                }
                return NavigationActionPolicy.ALLOW;
              }

              /// check if url return exact state that we pass in fetchprofileurl
              if (currentStateForUAEPassLogin != currentState) {
                code = null;
              }

              /// check if code is valid or not
              if (code != null) {
                /// use access code for finding uae pass profile data from access code
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
  void dispose() async {
    super.dispose();
    await GetIt.instance.reset();
    showLoadingStreamController.close();
    routeStreamController.close();
  }

  void goBack(
    BuildContext context, {
    dynamic result,
  }) {
    routeStreamController.add(true);
    Navigator.pop(context, result);
  }

  PreferredSizeWidget webViewAppbar({
    Color? backgroundColor,
    Widget? titleWidget,
    double? titleSpacing,
    bool? centerTitle,
    bool? automaticallyImplyLeading,
    Widget? backIcon,
    double? elevation,
    List<Widget>? actions,
    Color? shadowColor,
  }) =>
      AppBar(
        elevation: elevation,
        systemOverlayStyle: widget.isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        backgroundColor: backgroundColor,
        title: titleWidget ??
            Text(
              UaePassAppLocalizations.of(context).translate(kLabelTitleUaePass),
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: kFontFamilyGeFlow,
              ),
            ),
        shadowColor: shadowColor,
        titleSpacing: titleSpacing,
        centerTitle: centerTitle ?? false,
        automaticallyImplyLeading: automaticallyImplyLeading ?? false,
        leading: backIcon ??
            IconButton(
              onPressed: () async {
                if (webView != null && await webView!.canGoBack()) {
                  await webView!.goBack();
                } else {
                  await onClickBack();
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
        actions: actions,
      );
}
