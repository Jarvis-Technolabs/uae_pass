import 'package:flutter/material.dart';
import 'package:ft_uaepass/src/core/di/injection_container.dart';
import 'package:ft_uaepass/src/core/flavour/flavour.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/app_bar_properties.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/models/uae_pass_web_view_result_model.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/data/repository/uae_pass_repo_impl.dart';
import 'package:ft_uaepass/src/features/uae_pass_web_view/presentation/uae_pass_web_view_page.dart';

///This class allows to signIn with Uae Pass
class UaePass {
  late BuildContext context;
  late String? clientId;
  late String? clientSecret;
  late String redirectUrl;
  late String state;

  /// set to false for sandbox, Default is true
  bool isProduction = true;
  bool isDarkMode = false;

  ///Use appBar for replacing the default app bar UI
  PreferredSizeWidget? appBar;

  ///AppBarProperties is useful when you want customize the default app bar UI
  AppBarProperties? appBarProperties;

  UaePass({
    required this.context,
    this.clientId,
    this.clientSecret,
    required this.redirectUrl,
    required this.state,
    this.isProduction = true,
    this.isDarkMode = false,
    this.appBar,
    this.appBarProperties,
  });

  ///Set the environment base on isProduction
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
        clientId: clientId,
        clientSecret: clientSecret,
        redirectUrl: redirectUrl,
        state: state,
      );
    }
  }

  ///Sets the environment and navigate to web view for sign in
  Future<UAEPassWebViewResultModel?> signIn() async {
    await _setUpEnvironment();
    UAEPassWebViewResultModel? uaePassWebViewResultModel = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => UAEPassWebViewPage(
          isDarkMode: isDarkMode,
          appBarProperties: appBarProperties,
          appBar: appBar,
        ),
      ),
    );
    return uaePassWebViewResultModel;
  }
}
