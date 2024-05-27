import 'package:flutter/material.dart';
import 'package:uae_pass/src/core/di/injection_container.dart';
import 'package:uae_pass/src/core/flavour/flavour.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/models/uae_pass_web_view_result_model.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/data/repository/uae_pass_repo_impl.dart';
import 'package:uae_pass/src/features/uae_pass_web_view/presentation/uae_pass_web_view_page.dart';

class UaePass {
  late BuildContext context;
  late String? clientId;
  late String? clientSecret;
  late String redirectUrl;

  ///
  late String state;

  /// set to false for sandbox, Default is true
  bool isProduction = true;
  bool isDarkMode = false;

  UaePass({
    required this.context,
    this.clientId,
    this.clientSecret,
    required this.redirectUrl,
    required this.state,
    this.isProduction = true,
    this.isDarkMode = false,
  });

  Future<void> _setUpEnvironment() async {
    if (!sl.isRegistered<UaePassRepoImpl>(instanceName: "UaePassRepo")) {
      await init();
    }
    if (isProduction) {
      if (clientId == null || clientSecret == null) {
        throw StateError(
            "'clientId' and 'clientSecret' are required for production.");
      } else if (clientId == null) {
        throw StateError("'clientId' is required for production.");
      } else if (clientSecret == null) {
        throw StateError("'clientSecret' is required for production.");
      } else {
        Flavour.setProdFlavor(
          clientId: clientId!,
          clientSecret: clientSecret!,
          redirectUrl: redirectUrl,
          state: state,
        );
      }
    } else {
      Flavour.setStagingFlavor(
        redirectUrl: redirectUrl,
        state: state,
      );
    }
  }

  Future<UAEPassWebViewResultModel?> signIn() async {
    await _setUpEnvironment();
    UAEPassWebViewResultModel? uaePassWebViewResultModel = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => UAEPassWebViewPage(
          isDarkMode: isDarkMode,
        ),
      ),
    );
    return uaePassWebViewResultModel;
  }
}
