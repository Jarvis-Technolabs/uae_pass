import 'package:flutter/material.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/UAEPassWebViewResultModel.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/presentation/uae_pass_web_view_page.dart';

class UaePass {
  static signIn({
    required BuildContext context,
  }) async {
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
