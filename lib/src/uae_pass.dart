import 'package:flutter/material.dart';
import 'package:uae_pass/src/core/di/injection_container.dart';
import 'package:uae_pass/src/core/flavour/flavour.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/uae_pass_web_view_result_model.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/presentation/uae_pass_web_view_page.dart';

class UaePass {
  late BuildContext context;
  late String clientId;
  late String clientSecret;
  late String redirectUrl;

  ///
  late String state;

  /// set to false for sandbox
  bool isProduction = true;

  UaePass({
    required this.context,
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    required this.state,
    this.isProduction = true,
  });

  Future<void> setUpEnvironment() async {
    await init();
    if (isProduction) {
      Flavour.setProdFlavor(
        clientId: clientId,
        clientSecret: clientSecret,
        redirectUrl: redirectUrl,
        state: state,
      );
    } else {
      Flavour.setStagingFlavor(
        redirectUrl: redirectUrl,
        state: state,
      );
    }
  }

  Future<void> signIn() async {
    await setUpEnvironment();
    UAEPassWebViewResultModel model = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const UAEPassWebViewPage(),
      ),
    );
    if (model.status) {
      ///todo: return model data
    } else {
      // if (model.errorType == PROFILE_ERROR_USER_TYPE_SOP1) {
      //   await stateErrorWithChild(
      //       ApiErrorState(model.message, model.errorType, shouldGoBack: false),
      //       child: UAEPassMessageText(screenUtil, appColors),
      //       shouldGoBack: false);
      // } else {
      //   await stateErrorWithChild(
      //       ApiErrorState(model.message, model.errorType, shouldGoBack: false),
      //       errorMessage: model.message,
      //       shouldGoBack: false);
      // }
    }
  }
}
